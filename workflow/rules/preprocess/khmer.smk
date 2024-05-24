rule preprocess__khmer__interleave__:
    input:
        forward_=FASTP / "{sample_id}.{library_id}_1.fq.gz",
        reverse_=FASTP / "{sample_id}.{library_id}_2.fq.gz",
    output:
        interleaved=KHMER / "{sample_id}.{library_id}.interleaved.fq.gz",
    log:
        KHMER / "{sample_id}.{library_id}.interleaved.log",
    conda:
        "__environment__.yml"
    shell:
        """
        ( interleave-reads.py \
            {input.forward_} \
            {input.reverse_} \
        | pigz \
            --processes {threads} \
            --stdout \
        > {output.interleaved} \
        ) 2> {log}
        """


rule preprocess__khmer__trim_low_abund__:
    input:
        interleaved=KHMER / "{sample_id}.{library_id}.interleaved.fq.gz",
    output:
        filtered=KHMER / "{sample_id}.{library_id}.filtered.fq.gz",
    log:
        KHMER / "{sample_id}.{library_id}.filtered.log",
    conda:
        "__environment__.yml"
    params:
        ksize=params["preprocess"]["khmer"]["ksize"],
        cutoff=params["preprocess"]["khmer"]["cutoff"],
        max_memory_usage=params["preprocess"]["khmer"]["max_memory_usage"],
        temp_dir=lambda w: KHMER / f"{w.sample_id}.{w.library_id}",
    shell:
        """
        trim-low-abund.py \
            --ksize {params.ksize} \
            --cutoff {params.cutoff} \
            --max-memory-usage {params.max_memory_usage} \
            --output >(pigz --processes {threads} {output.filtered}) \
            {input.interleaved} \
        2> {log} 1>&2
        """


rule preprocess__khmer__extract_paired_reads__:
    input:
        filtered=KHMER / "{sample_id}.{library_id}.filtered.fq.gz",
    output:
        extracted=KHMER / "{sample_id}.{library_id}.extracted.fq.gz",
    log:
        KHMER / "{sample_id}.{library_id}.extracted.log",
    conda:
        "__environment__.yml"
    shell:
        """
        extract-paired-reads.py \
            --output-paired >(pigz --processes {threads} {output.extracted}) \
            --output-single /dev/null \
            {input.filtered} \
        2> {log} 1>&2
        """


rule preprocess__khmer__split_paired_reads__:
    input:
        extracted=KHMER / "{sample_id}.{library_id}.extracted.fq.gz",
    output:
        forward_=KHMER / "{sample_id}.{library_id}_1.fq.gz",
        reverse_=KHMER / "{sample_id}.{library_id}_2.fq.gz",
    log:
        KHMER / "{sample_id}.{library_id}.split.log",
    conda:
        "__environment__.yml"
    shell:
        """
        split-paired-reads.py \
            --output-first >(pigz --processes {threads} > {output.forward_}) \
            --output-second >(pigz --processes {threads} > {output.reverse_}) \
            {input.extracted} \
        2> {log} 1>&2
        """


rule preprocess__khmer:
    input:
        [
            KHMER / f"{sample_id}.{library_id}_{end}.fq.gz"
            for sample_id, library_id in SAMPLE_LIBRARY
            for end in [1, 2]
        ],


# genomes
# trim-low-abund.py -C 10 -M 2e9 <all of your input read files>
# metagenomes, metatranscriptomes, transcriptomes:
# trim-low-abund.py -C 3 -Z 18 -V -M 2e9 <all of your input read files>
