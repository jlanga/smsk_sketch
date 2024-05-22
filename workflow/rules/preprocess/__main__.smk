include: "__functions__.smk"
include: "fastp.smk"
include: "khmer.smk"


rule preprocess:
    input:
        # rules.preprocess__fastp.input,
        rules.preprocess__khmer.input,
