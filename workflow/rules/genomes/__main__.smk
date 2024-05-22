include: "__functions__.smk"
include: "link.smk"


rule genomes:
    input:
        rules.genomes__link.input,
