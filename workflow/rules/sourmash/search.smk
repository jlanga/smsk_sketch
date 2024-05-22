rule sourmash__search__:
    input:
        sig=SOUR_READS / "{sample_id}.{library_id}.sig",
        zip=SOUR_INDEX / "genomes.sbt.zip",
    output:
        tsv=SOUR_SEARCH / "{sample_id}.{library_id}.tsv",
    log:
        log=SOUR_SEARCH / "{sample_id}.{library_id}.log",
    conda:
        "__environment__.yml"
    params:
        ksize=params["sourmash"]["index"]["ksize"],
    shell:
        """
        sourmash search \
            --dna \
            --output {output.tsv} \
            --ksize {params.ksize} \
            {input.sig} \
            {input.zip} \
        2> {log} 1>&2
        """


rule sourmash__search:
    input:
        [
            SOUR_SEARCH / f"{sample_id}.{library_id}.tsv"
            for sample_id, library_id in SAMPLE_LIBRARY
        ],
