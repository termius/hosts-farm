#include <security/pam_modules.h>
#include <syslog.h>

int pam_sm_authenticate(pam_handle_t *pamh, int flags, int argc,
                        const char **argv) {
  openlog("termius_pam", LOG_NDELAY, LOG_AUTH);
  syslog(LOG_INFO, "%s", "STARTED");
  struct pam_message messages[4] = {
      {PAM_TEXT_INFO,
       "Hello\nto testing pam example\nfor testing\ncomplex\nkeyboard "
       "interactive\nprompts that\neven use links: https://termius.com\nand "
       "https://termius.com/teams\n"},
      {PAM_TEXT_INFO, "Another message "},
      {PAM_PROMPT_ECHO_ON, "Enter username: "},
      {PAM_PROMPT_ECHO_OFF, "Enter passphare: "},
      {PAM_PROMPT_ECHO_ON, "Enter your name: "},
  };
  const struct pam_message *message_vector[4];
  struct pam_conv *conv;
  struct pam_response*	response_array = 0;
  int i;
  for (i = 0; i < 4; i += 1)
    message_vector[i] = &messages[i];

  int result;
  result = pam_get_item(pamh, PAM_CONV, (void *)&conv);
  if (result != PAM_SUCCESS) {
    syslog(LOG_ERR, "%s", "Failure retrieving PAM conversation");
    return PAM_AUTH_ERR;
  }
  result = (*conv->conv)(4, (const struct pam_message**) message_vector, &response_array, conv->appdata_ptr);
  if (result != PAM_SUCCESS) {
    syslog(LOG_ERR, "%s %i %i %i", "Failure call PAM conversation", result, PAM_CONV_ERR, PAM_BUF_ERR);
    return PAM_AUTH_ERR;
  }
  free(response_array);
  return PAM_SUCCESS;
}

int pam_sm_acct_mgmt(pam_handle_t *pamh, int flags, int argc,
                     const char **argv) {
  return PAM_IGNORE;
}

int pam_sm_close_session(pam_handle_t *pamh, int flags, int argc,
                         const char **argv) {
  return PAM_SUCCESS;
}

int pam_sm_chauthtok(pam_handle_t *pamh, int flags, int argc,
                     const char **argv) {
  return PAM_IGNORE;
}

int pam_sm_open_session(pam_handle_t *pamh, int flags, int argc,
                        const char **argv) {
  return PAM_SUCCESS;
}

int pam_sm_setcred(pam_handle_t *pamh, int flags, int argc, const char **argv) {
  return PAM_IGNORE;
}
