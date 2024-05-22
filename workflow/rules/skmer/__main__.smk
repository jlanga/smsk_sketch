include: "__functions__.smk"
include: "reference.smk"


rule skmer:
    input:
        rules.skmer__reference.input,
