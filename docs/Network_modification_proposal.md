# Network Modification Proposal

## Purpose

This document outlines the minimum master GEOME network changes required to support the proposed folded material model shown in the visualizer, plus a staged migration path for existing team data.

The target model is:

- `Event`
- `EnvironmentalPackage`
- `Sample`
- `Diagnostics`
- `Sample_Photo`
- `Event_Photo`
- `derivedData`

Within this proposal:

- `Sample` becomes the single material-entity table
- `materialEntityType` distinguishes `sample`, `tissue`, and `dnaExtract`
- `parentMaterialSampleID` records derivation lineage
- `derivedData` absorbs the roles now handled by `fastaSequence` and `fastqMetadata`

## Why The Master Network Must Change

Team and project configs in `geome-db` are not freeform schemas. They are overlays on top of registered network entities and network attributes.

The key implications from `geome-db` are:

- Project entities must already exist in the network config.
- Project attributes must already exist on the corresponding network entity.
- Parent entity, concept URI, record type, and entity type must match the network definition.
- Network lists must be present in project configs and cannot differ when the alias matches a network list.

Operationally, that means the following proposal items cannot be introduced only at the team level:

- new entity `derivedData`
- new `Sample` attributes `materialEntityType` and `parentMaterialSampleID`
- changing the intended semantic role of `Sample` to absorb `Tissue` and `Extraction`
- eventual retirement of `fastaSequence`, `fastqMetadata`, `Tissue`, and `Extraction`

One nuance:

- A new list alias can technically be team-local if it does not collide with a network list alias.
- In practice, because `materialEntityType` is a new `Sample` attribute, the master network still needs to be updated first.

## Recommended Network Schema Patch

### Step 1: Add New `Sample` Attributes

Add these attributes to the master `Sample` entity:

- `materialEntityType`
  - datatype: `STRING`
  - required controlled vocabulary
  - purpose: classify each row as `sample`, `tissue`, or `dnaExtract`
- `parentMaterialSampleID`
  - datatype: `STRING`
  - optional
  - purpose: point to the parent material entity in the derivation chain

Recommended semantics:

- `sample`
  - top-level collected or accessioned material entity
- `tissue`
  - subsample derived from a sample
- `dnaExtract`
  - extraction output derived from a sample or tissue

Recommended network list:

- alias: `materialEntityType`
- values:
  - `sample`
  - `tissue`
  - `dnaExtract`

Recommended network rule on `Sample`:

- `ControlledVocabulary` on `materialEntityType` using list `materialEntityType`

Recommended interpretation rule:

- `parentMaterialSampleID` is blank for top-level `sample`
- `parentMaterialSampleID` is expected for `tissue`
- `parentMaterialSampleID` is expected for `dnaExtract`

This last rule can be implemented later as a custom conditional rule if needed. It does not need to block the first network patch.

### Step 2: Add New Entity `derivedData`

Add a new network entity:

- concept alias: `derivedData`
- parent entity: `Sample`
- unique key: `derivedDataID`
- worksheet: `DerivedData`

Minimum baseline fields:

- `derivedDataID`
- `materialSampleID`

Recommended content:

- adopt the GBIF DNA Derived Data extension fields already used in the visualizer proposal
- treat this entity as metadata for downstream molecular data products and workflows

Recommended scope statement:

- `derivedData` stores metadata about downstream DNA-derived digital products and molecular workflows, including sequencing context, assay setup, extract quality metrics, primers, and sequence outputs generated from the material.

### Step 3: Keep Existing Entities During Transition

Do not remove these entities in the first network patch:

- `Tissue`
- `Extraction`
- `fastaSequence`
- `fastqMetadata`

Also keep:

- `Diagnostics`
- `EnvironmentalPackage`
- `Sample_Photo`
- `Event_Photo`

This keeps the change backward-compatible while new teams or pilot teams adopt the folded model.

## Deprecation Strategy

Use a staged deprecation rather than a hard cutover.

### Phase A: Introduce New Model Without Breaking Existing Teams

Network changes:

- add `materialEntityType`
- add `parentMaterialSampleID`
- add `derivedData`
- keep `Tissue`, `Extraction`, `fastaSequence`, and `fastqMetadata`

Team-level guidance:

- new teams should use folded `Sample` plus `derivedData`
- existing teams may continue using current entities unchanged

### Phase B: Dual-Support Period

Allow both representations:

- legacy:
  - `Sample`
  - `Tissue`
  - `Extraction`
  - `fastaSequence`
  - `fastqMetadata`
- new:
  - folded `Sample`
  - `derivedData`

During this period:

- document canonical mappings from legacy entities to new ones
- expose import/export transforms where possible
- mark legacy entities as deprecated in UI and docs, but do not reject them

### Phase C: Soft Deprecation

Soft deprecate:

- `Tissue`
- `Extraction`
- `fastaSequence`
- `fastqMetadata`

Soft deprecation means:

- no new teams are created with those entities by default
- upload/template generation warns that they are legacy
- transforms continue to support them
- reporting tools can still read them

### Phase D: Hard Deprecation

Only after migration is complete:

- stop generating legacy templates
- stop allowing new project configs to enable legacy entities
- keep read-only support for historical data if needed

## Data Migration Rules

### Legacy `Tissue` To Folded `Sample`

For each legacy `Tissue` row:

- create a folded `Sample` row with `materialEntityType = tissue`
- carry over all tissue-specific attributes
- set `parentMaterialSampleID` to the parent sample identifier
- preserve the original `tissueID`

Recommended identifier policy:

- if a folded row represents a historical tissue, continue to preserve `tissueID` as a retained attribute
- do not overwrite `materialSampleID` unless a formal canonical-ID strategy is adopted

### Legacy `Extraction` To Folded `Sample`

For each legacy `Extraction` row:

- create a folded `Sample` row with `materialEntityType = dnaExtract`
- carry over extraction-specific attributes
- set `parentMaterialSampleID` to the source tissue or sample row
- preserve the original `extractionID`

### Legacy `fastaSequence` And `fastqMetadata` To `derivedData`

For each legacy sequence metadata row:

- create a `derivedData` row
- map the parent to the relevant material entity via `materialSampleID`
- preserve original sequence identifiers in carried fields where needed
- map assay, primer, run, sequence, and molecular metadata into the GBIF-derived field set

Recommended interpretation:

- `fastaSequence`
  - maps to sequence-centric `derivedData`
- `fastqMetadata`
  - maps to run/library-centric `derivedData`

If necessary, introduce a `derivedDataSubtype` list later to distinguish:

- `fastaSequence`
- `fastqRun`
- `ampliconResult`
- `assembly`
- `variantCall`

That subtype is optional. It is not required to start the network patch.

## Data Migration Steps Required

### 1. Freeze The Mapping Specification

Before changing live team configs:

- define canonical column mappings from `Tissue` to folded `Sample`
- define canonical column mappings from `Extraction` to folded `Sample`
- define canonical column mappings from `fastaSequence` and `fastqMetadata` to `derivedData`
- define identifier retention policy for `tissueID`, `extractionID`, and FASTA/FASTQ identifiers

### 2. Update The Master Network Config

Apply the network patch first:

- add `materialEntityType` list
- add `materialEntityType` and `parentMaterialSampleID` to `Sample`
- add `derivedData`
- retain legacy entities during transition

### 3. Update Template Generation

Update spreadsheet/template generation so teams can choose:

- legacy model
- folded model

Prefer the folded model for new teams after validation.

### 4. Build Migration Utilities

Add transforms that can:

- convert legacy project exports into folded-format uploads
- preserve parent-child lineage
- preserve BCID and identifier references
- emit warnings for ambiguous mappings

### 5. Pilot On One Team First

Do not migrate all teams at once.

Recommended pilot:

- Biocode team

Rationale:

- it already mixes sample and tissue information on the `Samples` sheet
- it already supports FASTA and FASTQ uploads
- its workflow is close to the folded-material concept

## Biocode Team Migration Path

### Current Biocode State

The Biocode team currently:

- uses an `Event` sheet
- uses a `Samples` sheet that already combines sample and tissue metadata
- repeats sample rows to represent multiple tissues
- uses `sample_photos` and `event_photos`
- accepts FASTA metadata plus sequences
- accepts FASTQ metadata

This makes Biocode the best first candidate for migration.

### Proposed Biocode Migration

#### Step 1: Add New Fields Without Removing Anything

Add to Biocode `Samples` workflow:

- `materialEntityType`
- `parentMaterialSampleID`

Do not remove current tissue fields yet.

Immediate usage:

- top specimen rows use `materialEntityType = sample`
- repeated tissue rows use `materialEntityType = tissue`
- extraction-like folded rows use `materialEntityType = dnaExtract`

#### Step 2: Introduce `derivedData` Upload Path

Create a `DerivedData` worksheet or upload path for Biocode:

- one row per FASTA sequence product or FASTQ run/library metadata object
- parent linked through `materialSampleID`

Keep legacy FASTA and FASTQ ingestion available during the pilot.

#### Step 3: Backfill Historical Biocode Data

For existing Biocode projects:

- preserve current `Sample` rows as-is
- convert historical tissue records to folded `Sample` rows with `materialEntityType = tissue`
- convert historical extraction records, if present, to folded `Sample` rows with `materialEntityType = dnaExtract`
- convert historical FASTA and FASTQ records to `derivedData`

Important:

- do not delete historical legacy rows before equivalence has been validated
- keep a crosswalk table from old IDs to new folded rows

Recommended crosswalk fields:

- `legacyEntity`
- `legacyIdentifier`
- `newEntity`
- `newIdentifier`
- `migrationBatch`

#### Step 4: Validate Biocode Reporting And Submission Flows

Before declaring migration complete, verify:

- project template generation
- spreadsheet validation
- BCID generation and linking
- photo linking
- FASTA export behavior
- FASTQ or SRA package generation behavior
- query/export tools that expect `Tissue`, `Extraction`, `fastaSequence`, or `fastqMetadata`

#### Step 5: Make Biocode Folded Model The Default

After successful validation:

- make folded `Sample` + `derivedData` the default Biocode configuration
- keep legacy imports available behind compatibility mode for a transition window

## Migration Risks

### Identifier Ambiguity

Risk:

- legacy `sampleID`, `tissueID`, `extractionID`, FASTA identifiers, and FASTQ identifiers may not map one-to-one without ambiguity

Mitigation:

- preserve all legacy identifiers during migration
- create explicit crosswalks
- do not collapse IDs silently

### Parentage Loss

Risk:

- historical tissue and extraction lineage may be incomplete

Mitigation:

- allow `parentMaterialSampleID` to be temporarily blank for legacy backfill when true parentage is unknown
- capture unresolved lineage in migration logs

### Behavioral Regression In Downstream Services

Risk:

- services may assume `Tissue`, `Extraction`, `fastaSequence`, or `fastqMetadata` still exist

Mitigation:

- dual-support period
- compatibility transforms
- pilot on Biocode before wider rollout

## Recommended Minimal First Patch

If the goal is to move incrementally, the smallest useful master-network patch is:

1. Add `materialEntityType` list to the network config.
2. Add `materialEntityType` and `parentMaterialSampleID` to `Sample`.
3. Add new entity `derivedData`.
4. Keep all legacy entities unchanged.
5. Pilot only at Biocode team level first.

This creates the migration path without forcing any immediate breakage.

## Recommendation

Proceed in this order:

1. Patch the master GEOME network with the minimum new elements.
2. Keep legacy entities active.
3. Build migration transforms and ID crosswalk support.
4. Pilot with Biocode.
5. Soft deprecate legacy molecular/material entities only after the pilot is stable.
