from time import sleep


def pam_sm_acct_mgmt(pamh, flags, args):
    print "pam_sm_acct_mgmt pamh ({}), flags ({}), args ({})".format(pamh, flags, args)
    return pamh.PAM_SUCCESS

def pam_sm_authenticate(pamh, flags, args):
    print "pam_sm_authenticate pamh ({}), flags ({}), args ({})".format(pamh, flags, args)
    response = pamh.conversation([
        pamh.Message(pamh.PAM_TEXT_INFO, (
            "Hello\n"
            "to testing pam example\n"
            "for testing\n"
            "complex\n"
            "keyboard interactive\n"
            "prompts that\n"
            "even use links: https://termius.com\n"
            "and https://termius.com/teams\n"
        )),
        pamh.Message(pamh.PAM_PROMPT_ECHO_ON, "Enter username: "),
        pamh.Message(pamh.PAM_PROMPT_ECHO_OFF, "Enter password: "),
        pamh.Message(pamh.PAM_PROMPT_ECHO_ON, "Enter your name: "),
    ])
    sleep(5)
    response = pamh.conversation([
        pamh.Message(pamh.PAM_TEXT_INFO, (
            "This is the last message\n"
            "buy"
        )),
    ])
    return pamh.PAM_SUCCESS

def pam_sm_close_session(pamh, flags, args):
    print "pam_sm_close_session pamh ({}), flags ({}), args ({})".format(pamh, flags, args)
    return pamh.PAM_SUCCESS


def pam_sm_chauthtok(pamh, flags, args):
    print "pam_sm_chauthtok pamh ({}), flags ({}), args ({})".format(pamh, flags, args)
    return pamh.PAM_SUCCESS


def pam_sm_open_session(pamh, flags, args):
    print "pam_sm_open_session pamh ({}), flags ({}), args ({})".format(pamh, flags, args)
    return pamh.PAM_SUCCESS


def pam_sm_setcred(pamh, flags, args):
    return pamh.PAM_SUCCESS
