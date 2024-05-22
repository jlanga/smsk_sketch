rule sylph__profile__:
    input:
        reads=[
            SYLPH_SKETCH / f"{sample_id}.{library_id}.paired.sylsp"
            for sample_id, library_id in SAMPLE_LIBRARY
        ],
        genomes=SYLPH_SKETCH / "genomes.syldb",
    output:
        SYLPH_PROFILE / "profile.tsv",
    log:
        SYLPH_PROFILE / "profile.log",
    conda:
        "__environment__.yml"
    shell:
        """
        sylph profile \
            -t {threads} \
            --output-file {output} \
            {input.genomes} \
            {input.reads} \
        2> {log} 1>&2
        """


rule sylph__profile:
    input:
        rules.sylph__profile__.output,
