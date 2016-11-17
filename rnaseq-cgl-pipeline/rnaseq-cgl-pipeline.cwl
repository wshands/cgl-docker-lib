#!/usr/bin/env cwl-runner

class: CommandLineTool
id: "RNA-seq-CGL"
label: "RNA-seq CGL Pipeline"
cwlVersion: v1.0
doc: |
    ![build_status](https://quay.io/ucsc_cgl/rnaseq-cgl-pipeline/status)
    The RNA-seq CGL pipeline.
    ```
    Usage:
    # fetch CWL
    $> dockstore tool cwl --entry quay.io/ucsc_cgl/rnaseq-cgl-pipeline > rnaseq-cgl-pipeline.cwl
    # make a runtime JSON template and edit it
    $> dockstore tool convert cwl2json --cwl rnaseq-cgl-pipeline.cwl > rnaseq-cgl-pipeline.json
    # run it locally with the Dockstore CLI
    $> dockstore tool launch --entry quay.io/ucsc_cgl/rnaseq-cgl-pipeline  --json rnaseq-cgl-pipeline.json
    ```

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/ucsc_cgl/rnaseq-cgl-pipeline"
hints:
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 4092
    outdirMin: 512000
    description: "the process requires at least 4G of RAM"

inputs:
  samples:
    doc: "Absolute path(s) to sample tarballs."
    type:
      type: array
      items: File
    inputBinding:
      prefix: --samples

  star:
    type: string
    doc: "Absolute path to STAR index tarball."
    inputBinding:
      prefix: --star

  rsem:
    type: string
    doc: "Absolute path to rsem reference tarball."
    inputBinding:
      prefix: --rsem

  kallisto:
    type: string
    doc: "Absolute path to kallisto index (.idx) file."
    inputBinding:
      prefix: --kallisto
 
  disable-cutadapt:
    type: boolean?
    default: false
    doc: "Cutadapt fails if samples are improperly paired. Use this flag to disable cutadapt."
    inputBinding:
      prefix: --disable-cutadapt

  save-bam:
    type: boolean?
    default: false
    doc: "If this flag is used, genome-aligned bam is written to output."
    inputBinding:
      prefix: --save-bam

  save-wiggle:
    type: boolean?
    default: false
    doc: "If this flag is used, wiggle files (.bg) are written to output."
    inputBinding:
      prefix: --save-wiggle

  no-clean:
    type: boolean?
    default: true
    doc: "If this flag is used, temporary work directory is not cleaned."
    inputBinding:
      prefix: --no-clean

  resume:
    type: string?
    doc: "Path of the working directory that contains a job store to be resumed."
    inputBinding:
      prefix: --resume

  cores:
    type: int?
    doc: "Will set a cap on number of cores to use, default is all available cores."
    inputBinding:
      prefix: --cores

outputs:
  output_files:
    type:
      type: array
      items: File
    outputBinding:
      # should be put in the working directory
       glob: ./*
    doc: "Result files RNA-seq CGL pipeline"

baseCommand: ["wrapper.py"]


