rule sourmash__sketch__reads__:
    input:
        forward_=KHMER / "{sample_id}.{library_id}_1.fq.gz",
        reverse_=KHMER / "{sample_id}.{library_id}_2.fq.gz",
    output:
        sketch=SOUR_READS / "{sample_id}.{library_id}.sig",
    log:
        SOUR_READS / "{sample_id}.{library_id}.log",
    conda:
        "__environment__.yml"
    params:
        param_string=params["sourmash"]["sketch"]["reads"]["param_string"],
    shell:
        """
        sourmash sketch dna \
            --param-string '{params.param_string}' \
            --output {output.sketch} \
            {input.forward_} \
            {input.reverse_} \
        2> {log}
        """


rule sourmash__sketch__reads:
    input:
        [
            SOUR_READS / f"{sample_id}.{library_id}.sig"
            for sample_id, library_id in SAMPLE_LIBRARY
        ],


rule sourmash__sketch__genomes__:
    input:
        GENOMES / "{genome}.fa.gz",
    output:
        sketch=SOUR_GENOMES / "{genome}.sig",
    log:
        SOUR_GENOMES / "{genome}.log",
    conda:
        "__environment__.yml"
    params:
        param_string=params["sourmash"]["sketch"]["genomes"]["param_string"],
    shell:
        """
        sourmash sketch dna \
            --param-string '{params.param_string}' \
            --output {output.sketch} \
            {input} \
        2> {log}
        """


rule sourmash__sketch__genomes:
    input:
        [SOUR_GENOMES / f"{genome}.sig" for genome in GENOME_LIST],
