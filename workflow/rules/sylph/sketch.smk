rule sylph__sketch__genomes__:
    input:
        [GENOMES / f"{genome}.fa.gz" for genome in GENOME_LIST],
    output:
        SYLPH_SKETCH / "genomes.syldb",
    log:
        SYLPH_SKETCH / "genomes.log",
    conda:
        "__environment__.yml"
    params:
        prefix=SYLPH_SKETCH / "genomes",
    shell:
        """
        sylph sketch \
            --out-name-db {params.prefix} \
            {input} \
        2> {log} 1>&2
        """


rule sylph__sketch__sample__:
    input:
        forward_=KHMER / "{sample_id}.{library_id}_1.fq.gz",
        reverse_=KHMER / "{sample_id}.{library_id}_2.fq.gz",
    output:
        SYLPH_SKETCH / "{sample_id}.{library_id}.paired.sylsp",
    log:
        SYLPH_SKETCH / "{sample_id}.{library_id}.log",
    conda:
        "__environment__.yml"
    params:
        sample_name=lambda w: f"{w.sample_id}.{w.library_id}",
        prefix=lambda w: SYLPH_SKETCH / f"{w.sample_id}.{w.library_id}",
    shell:
        """
        sylph sketch \
            --first-pairs {input.forward_} \
            --second-pairs {input.reverse_} \
            --sample-names {params.sample_name} \
            --sample-output-directory {SYLPH_SKETCH} \
            --out-name-db {params.prefix} \
        2> {log} 1>&2
        """


rule sylph__sketch:
    input:
        rules.sylph__sketch__genomes__.output,
        [
            SYLPH_SKETCH / f"{sample_id}.{library_id}.paired.sylsp"
            for sample_id, library_id in SAMPLE_LIBRARY
        ],
