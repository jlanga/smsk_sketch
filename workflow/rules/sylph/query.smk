rule sylph__query__:
    input:
        reads=[
            SYLPH_SKETCH / f"{sample_id}.{library_id}.paired.sylsp"
            for sample_id, library_id in SAMPLE_LIBRARY
        ],
        genomes=SYLPH_SKETCH / "genomes.syldb",
    output:
        SYLPH_QUERY / "query.tsv",
    log:
        SYLPH_QUERY / "query.log",
    conda:
        "__environment__.yml"
    shell:
        """
        sylph query \
            -t {threads} \
            --output-file {output} \
            {input.genomes} \
            {input.reads} \
        > {log} 2>&1
        """


rule sylph__query:
    input:
        rules.sylph__query__.output,
