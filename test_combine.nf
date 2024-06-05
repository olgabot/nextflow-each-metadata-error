process test_combine {

    input:
    tuple val(meta), path(filename), val(number)

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


    input_ch_numbers = input_ch.combine(numbers)
    input_ch_numbers.view()

    test_combine(input_ch_numbers)

    test_combine.out.md_number.view()
}