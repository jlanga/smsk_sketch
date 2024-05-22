rule preprocess__fastp__:
    """Run fastp on one PE library"""
    input:
        forward_=READS / "{sample_id}.{library_id}_1.fq.gz",
        reverse_=READS / "{sample_id}.{library_id}_2.fq.gz",
    output:
        forward_=FASTP / "{sample_id}.{library_id}_1.fq.gz",
        reverse_=FASTP / "{sample_id}.{library_id}_2.fq.gz",
        html=FASTP / "{sample_id}.{library_id}_fastp.html",
        json=FASTP / "{sample_id}.{library_id}_fastp.json",
    log:
        FASTP / "{sample_id}.{library_id}.log",
    params:
        length_required=params["preprocess"]["fastp"]["length_required"],
        forward_adapter=get_forward_adapter,
        reverse_adapter=get_reverse_adapter,
    conda:
        "__environment__.yml"
    shell:
        """
        fastp \
            --in1 {input.forward_} \
            --in2 {input.reverse_} \
            --out1 >(pigz --processes {threads} > {output.forward_}) \
            --out2 >(pigz --processes {threads} > {output.reverse_}) \
            --adapter_sequence {params.forward_adapter} \
            --adapter_sequence_r2 {params.reverse_adapter} \
            --html {output.html} \
            --json {output.json} \
            --length_required {params.length_required} \
            --thread {threads} \
            --trim_poly_g \
            --trim_poly_x \
            --verbose \
        2> {log} 1>&2
        """


rule preprocess__fastp:
    """Run fastp over all libraries"""
    input:
        [
            FASTP / f"{sample_id}.{library_id}_{end}.fq.gz"
            for sample_id, library_id in SAMPLE_LIBRARY
            for end in ["1", "2"]
        ],
