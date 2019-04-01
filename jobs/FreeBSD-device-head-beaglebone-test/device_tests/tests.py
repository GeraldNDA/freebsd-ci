# Either (or both) of these lists should be defined. 
# The lists should be iterables of functions as specified below.
to_run = []
panic_actions = []

class TestFailure(Exception):
    pass

def check_status(ch, msg):
    ch.console.sendline("echo $?")
    res = ch.console.expect(["0", r"\d+"])
    if res == 1:
        errno = ch.console.match.group(0)
        if type(errno) is bytes:
            errno = errno.decode()
        raise TestFailure(f"Failed test with err {errno}: {msg}")
    ch.console.expect(ch.CMDLINE_RE)

def test_tls_initial_exec(ch):
    try:
        ch.console.sendline("cd test")
        ch.console.expect(ch.CMDLINE_RE)
        check_status(ch, "Moving to test directory")

        ch.console.sendline("make test")
        ch.console.expect(ch.CMDLINE_RE)
        check_status(ch, "Making test (and running test)")
        # DONE
    except TestFailure as e:
        return (False, str(e))

    return (True, None)

to_run.append(test_tls_initial_exec)