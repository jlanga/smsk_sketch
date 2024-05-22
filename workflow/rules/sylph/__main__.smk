include: "__functions__.smk"
include: "sketch.smk"


# include: "profile.smk"
# include: "query.smk"


rule sylph:
    input:
        rules.sylph__sketch.input,
