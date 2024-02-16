// Copyright (c) 2022 Termius Corporation.
#include <security/pam_modules.h>
#include <syslog.h>
#include <stddef.h>

#define DEFAULT_USER "nobody"
#define DEFAULT_PASSWORD "pass"
#define UNUSED

static void setcred_free(pam_handle_t *pamh UNUSED, void *ptr, int err UNUSED)
{
  pam_syslog(pamh, LOG_NOTICE, "Cleaned");
  free (ptr);
}

int pam_sm_authenticate(pam_handle_t *pamh, int flags, int argc,
                        const char **argv) {
  openlog("termius_pam", LOG_NDELAY, LOG_AUTH);
  pam_syslog(pamh, LOG_NOTICE, "STARTED");

  const char *user = NULL;
  int result;

  /*
    * authentication requires we know who the user wants to be
    */
  result = pam_get_user(pamh, &user, NULL);
  if (result != PAM_SUCCESS) {
    pam_syslog(pamh, LOG_ERR, "get user returned error: %s", pam_strerror(pamh, result));
    return result;
  }
  if (*user == '\0') {
    pam_syslog(pamh, LOG_ERR, "username not known");
    result = pam_set_item(pamh, PAM_USER, (const void *) DEFAULT_USER);
    if (result != PAM_SUCCESS) {
      return PAM_USER_UNKNOWN;
    }
  }

  struct pam_message messages[4] = {
      {PAM_TEXT_INFO,
       "Hello\nto testing pam example\nfor testing\ncomplex\nkeyboard "
       "interactive\nprompts that\neven use links: https://termius.com\nand "
       "https://termius.com/teams\n"},
      {PAM_PROMPT_ECHO_ON, "Enter username: "},
      {PAM_PROMPT_ECHO_OFF, "Enter passphare: "},
      {PAM_PROMPT_ECHO_ON, "Enter your name: "},
  };
  const struct pam_message *message_vector[4];
  struct pam_conv *conv;
  int i;
  for (i = 0; i < 4; i += 1) message_vector[i] = &messages[i];

  struct pam_message first_message = {
      PAM_TEXT_INFO, "This is the first message\nbefore every other message\n"};
  const struct pam_message *p_first_message = &first_message;

  struct pam_response *response_array = 0;
  result = pam_get_item(pamh, PAM_CONV, (void *)&conv);
  if (result != PAM_SUCCESS) {
    pam_syslog(pamh, LOG_ERR, "%s", "Failure retrieving PAM conversation");
    return PAM_AUTH_ERR;
  }

  result =
      (*conv->conv)(1, &p_first_message, &response_array, conv->appdata_ptr);
  if (result != PAM_SUCCESS) {
    pam_syslog(pamh, LOG_ERR, "%s %i %i %i", "Failure call PAM conversation", result,
           PAM_CONV_ERR, PAM_BUF_ERR);
    return PAM_AUTH_ERR;
  }
  free(response_array->resp);
  free(response_array);

  result = (*conv->conv)(4, (const struct pam_message **)message_vector,
                         &response_array, conv->appdata_ptr);
  if (result != PAM_SUCCESS) {
    pam_syslog(pamh, LOG_ERR, "%s %i %i %i", "Failure call PAM conversation", result,
           PAM_CONV_ERR, PAM_BUF_ERR);
    return PAM_AUTH_ERR;
  }
  for (i = 0; i < 4; i += 1) free((response_array + i)->resp);
  free(response_array);

  pam_syslog(pamh, LOG_NOTICE, "ALL GOOD auth as %s.", user);

  const char *authtok = NULL;
  result = pam_get_authtok(pamh, PAM_AUTHTOK, &authtok, "Password: ");
  if (result != PAM_SUCCESS) {
    pam_syslog(pamh, LOG_ERR, "%s", "Failure retrieving PAM authtok");
    return PAM_AUTH_ERR;
  }

  int *ret_data = NULL;
  ret_data = malloc(sizeof(int));
  if (!ret_data) {
    pam_syslog(pamh, LOG_CRIT, "cannot allocate ret_data");
    return PAM_BUF_ERR;
  }

  *ret_data = result;
  result = pam_set_data(pamh, "termius_setcred_return", (void *) ret_data, setcred_free);
  pam_syslog(pamh, LOG_NOTICE, "AUTH COMPLETED %d %d.", result, *ret_data);

  // password is match dummy password
  if (strcmp(authtok, DEFAULT_PASSWORD) != 0) {
    return PAM_CRED_ERR;
  }

  return PAM_SUCCESS;
}

int pam_sm_setcred(pam_handle_t *pamh, int flags, int argc, const char **argv) {
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
