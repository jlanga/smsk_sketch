rule sourmash__compare__samples__:
    input:
        [
            SOUR_READS / f"{sample_id}.{library_id}.sig"
            for sample_id, library_id in SAMPLE_LIBRARY
        ],
    output:
        SOUR_COMPARE / "reads",
    log:
        SOUR_COMPARE / "reads.log",
    conda:
        "__environment__.yml"
    shell:
        """
        sourmash compare \
            --output {output} \
            --processes {threads} \
            {input} \
        2> {log} 1>&2
        """


rule sourmash__compare__genomes__:
    input:
        [SOUR_GENOMES / f"{genome_id}.sig" for genome_id in GENOME_LIST],
    output:
        SOUR_COMPARE / "genomes",
    log:
        SOUR_COMPARE / "genomes.log",
    conda:
        "__environment__.yml"
    shell:
        """
        sourmash compare \
            --output {output} \
            --processes {threads} \
            {input} \
        2> {log} 1>&2
        """


rule sourmash__compare__all__:
    input:
        [
            SOUR_READS / f"{sample_id}.{library_id}.sig"
            for sample_id, library_id in SAMPLE_LIBRARY
        ],
        [SOUR_GENOMES / f"{genome_id}.sig" for genome_id in GENOME_LIST],
    output:
        SOUR_COMPARE / "all",
    log:
        SOUR_COMPARE / "all",
    conda:
        "__environment__.yml"
    shell:
        """
        sourmash compare \
            --output {output} \
            --processes {threads} \
            {input} \
        2> {log} 1>&2
        """


rule sourmash__compare__plot__:
    input:
        SOUR_COMPARE / "{comparison}",
    output:
        SOUR_COMPARE / "{comparison}.matrix.pdf",
        SOUR_COMPARE / "{comparison}.hist.pdf",
        SOUR_COMPARE / "{comparison}.dendro.pdf",
    log:
        SOUR_COMPARE / "{comparison}.plot.log",
    conda:
        "__environment__.yml"
    params:
        outdir=SOUR_COMPARE,
    shell:
        """
        sourmash plot \
            --pdf \
            --output-dir {params.outdir} \
            {input} \
        2> {log} 1>&2
        """


rule sourmash__compare:
    input:
        [
            SOUR_COMPARE / f"{comparison}.{visualization}.pdf"
            for comparison in ["all", "genomes", "reads"]
            for visualization in ["matrix", "hist", "dendro"]
        ],
