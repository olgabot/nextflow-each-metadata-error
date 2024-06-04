
process test_each {

    input:
    tuple val(meta), path(filename)
    each number

    output:
    tuple val(meta), path("*_*.md"), emit: md_number

    script:
    meta.number = number

    """
    touch ${filename.simpleName}_${number}.md
    """
}

workflow {
    // input_file = Channel.fromPath("README.md")
    input_ch = Channel.of([[id:"README"], file("README.md")])
    numbers = [1,2,3,4,5]

    input_ch.view()

    test_each(input_ch, numbers)

    test_each.out.md_number.view()
}