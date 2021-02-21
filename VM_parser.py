import re
import regex_patterns as rp

PUSH_CMD = "push"
POP_CMD = "pop"
BASE_TEMP_ADR = 5
MEMORY_LINE_TYPE = 3
ARITHMETIC_LINE_TYPE = 1
BOOLEAN_OPERATOR_COUNTER = 0
SOLID_MEMORY_segmentS = {"local": "LCL",
                         "argument": "ARG",
                         "this": "THIS",
                         "that": "THAT"}
VIRTUAL_MEMORY_segmentS = ["constant", "static", "pointer", "temp"]
POINTER = ["THIS", "THAT"]


def type_detector(line):
    return len(line.split())


def two_var_bool_op(jmp_operator):
    global BOOLEAN_OPERATOR_COUNTER
    BOOLEAN_OPERATOR_COUNTER += 1
    return [
        "\t@SP",
        "\tAM=M-1",
        "\tD=M",
        "\tA=A-1",
        "\tD=D-M",
        "\t@SP",
        "\tA=M-1",
        "\tM=-1",
        "\t@BOOL.OP.END." + str(BOOLEAN_OPERATOR_COUNTER),
        "\tD;" + jmp_operator,
        "\t@SP",
        "\tA=M-1",
        "\tM=0",
        "(BOOL.OP.END." + str(BOOLEAN_OPERATOR_COUNTER) + ")"
    ]


def new_bool_op(jmp_operator):
    global BOOLEAN_OPERATOR_COUNTER
    BOOLEAN_OPERATOR_COUNTER += 1
    first, second, JMP_CMD = "0", "0", "JLT"
    if jmp_operator == "gt":
        JMP_CMD = "JLT"
        first = "0"
        second = "-1"
    if jmp_operator == "lt":
        JMP_CMD = "JGT"
        first = "-1"
        second = "0"
    return [
        "\t@SP",
        "\tA=M-1",
        "\tD=M",  # D=y
        "\t@POSITIVE.Y." + str(BOOLEAN_OPERATOR_COUNTER),
        "\tD;JGE",  # if y>=0
        "\t@SP",
        "\tA=M-1",
        "\tA=A-1",  # get X
        "\tD=M",
        "\t@REG.COMP." + str(BOOLEAN_OPERATOR_COUNTER),
        "\tD;JLT",
        "\t@SP",  # return first result
        "\tAM=M-1",
        "\tA=A-1",
        "\tM=" + second,
        "\t@END.BOOL." + str(BOOLEAN_OPERATOR_COUNTER),
        "\t0;JMP",
        "\t@END.BOOL." + str(BOOLEAN_OPERATOR_COUNTER),
        "\t0;JMP",
        "(POSITIVE.Y." + str(BOOLEAN_OPERATOR_COUNTER) + ")",
        "\t@SP",
        "\tA=M-1",
        "\tA=A-1",  # get X
        "\tD=M",
        "\t@REG.COMP." + str(BOOLEAN_OPERATOR_COUNTER),
        "\tD;JGE",
        "\t@SP",  # return first result
        "\tAM=M-1",
        "\tA=A-1",
        "\tM=" + first,
        "\t@END.BOOL." + str(BOOLEAN_OPERATOR_COUNTER),
        "\t0;JMP",
        "(REG.COMP." + str(BOOLEAN_OPERATOR_COUNTER) + ")",
        "\t@SP",
        "\tAM=M-1",
        "\tD=M",
        "\tA=A-1",
        "\tD=D-M",
        "\t@SP",
        "\tA=M-1",
        "\tM=-1",
        "\t@END.BOOL." + str(BOOLEAN_OPERATOR_COUNTER),
        "\tD;" + JMP_CMD,
        "\t@SP",
        "\tA=M-1",
        "\tM=0",
        "(END.BOOL." + str(BOOLEAN_OPERATOR_COUNTER) + ")"
    ]


def two_var_arithmetic_op(operator):
    return [
        "\t@SP",
        "\tAM=M-1",
        "\tD=M",
        "\tA=A-1",
        "\tM=M" + operator + "D"
    ]


def one_var_arithmetic_op(operator):
    return [
        "\t@SP",
        "\tA=M-1",
        "\tM=" + operator + "M"
    ]


def arithmetic_line_parser(line):
    if line == 'add':
        return two_var_arithmetic_op('+')
    if line == 'sub':
        return two_var_arithmetic_op('-')
    if line == 'and':
        return two_var_arithmetic_op('&')
    if line == 'or':
        return two_var_arithmetic_op('|')
    if line == 'neg':
        return one_var_arithmetic_op('-')
    if line == 'not':
        return one_var_arithmetic_op('!')
    if line == 'eq':
        return two_var_bool_op('JEQ')
    if line == 'gt':
        return new_bool_op(line)
    if line == 'lt':
        return new_bool_op(line)


def solid_memory_segment_parser(command, segment, value):
    if command == PUSH_CMD:
        return [
            "\t@" + SOLID_MEMORY_segmentS[segment],
            "\tD=M",
            "\t@" + value,
            "\tA=D+A",
            "\tD=M",
            "\t@SP",
            "\tM=M+1",
            "\tA=M-1",
            "\tM=D"
        ]
    if command == POP_CMD:
        return [
            "\t@" + SOLID_MEMORY_segmentS[segment],
            "\tD=M",
            "\t@" + value,
            "\tD=D+A",
            "\t@SP",
            "\tA=M",
            "\tM=D",
            "\tA=A-1",
            "\tD=M",
            "\tA=A+1",
            "\tA=M",
            "\tM=D",
            "\t@SP",
            "\tM=M-1"
        ]


def virtual_push(symbol, register):
    return [
        "\t@" + symbol,
        "\tD=" + register,
        "\t@SP",
        "\tM=M+1",
        "\tA=M-1",
        "\tM=D",
    ]


def virtual_pop(symbol):
    return [
        "\t@SP",
        "\tM=M-1",
        "\tA=M",
        "\tD=M",
        "\t@" + symbol,
        "\tM=D"
    ]


def virtual_memory_segment_parser(command, segment, value, name):
    if segment == "pointer":
        if command == PUSH_CMD:
            return virtual_push(POINTER[int(value)], "M")
        if command == POP_CMD:
            return virtual_pop(POINTER[int(value)])
    if segment == "constant":
        # always a push command when segment is constant
        return virtual_push(value, "A")
    if segment == "static":
        if command == PUSH_CMD:
            return virtual_push(name + "." + value, "M")
        if command == POP_CMD:
            return virtual_pop(name + "." + value)
    if segment == "temp":
        if command == PUSH_CMD:
            return virtual_push('R' + str(BASE_TEMP_ADR + int(value)), "M")
        if command == POP_CMD:
            return virtual_pop('R' + str(BASE_TEMP_ADR + int(value)))


def memory_line_parser(line, name):
    command, segment, value = line.split(" ")
    if segment in SOLID_MEMORY_segmentS:
        return solid_memory_segment_parser(command, segment, value)
    if segment in VIRTUAL_MEMORY_segmentS:
        return virtual_memory_segment_parser(command, segment, value, name)


def line_stripper(line):
    match = re.match(rp.REDUNDANT_PARTS, line)
    if match is not None:
        return match.group('command').strip()
    return ["Parsing error! line : ###############################", line,
            "did not parse ###############################"]


def parse_line(line, name):
    if line is not None:
        line_type = type_detector(line)
        if line_type == MEMORY_LINE_TYPE:
            return memory_line_parser(line, name)
        if line_type == ARITHMETIC_LINE_TYPE:
            return arithmetic_line_parser(line)
    return None


def comment_ws_remover(lines):
    result = []
    for line in lines:
        if re.match(rp.COMMENT_REGEX, line):
            continue
        result.append(line)
    return result


def translate(lines, name):
    clean_lines = comment_ws_remover(lines)
    result = []
    for line in clean_lines:
        result.append("//" + line)
        result = result + parse_line(line_stripper(line), name)
    return result
