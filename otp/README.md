# One-Time PassWord Authentication (OTPW)

Password prefix is `1`.

## How to enter OTPW when connecting:

1. Enter the prefix `1`.
2. Look up the requested number(s) in the [keys](/otp/keys.txt) file (numbers are shown in the password prompt, e.g., `001` or `000/001/002`).
3. Enter the values under these numbers in the requested order:
   * No space between the prefix and the password
   * Spaces inside the password (between its halves) may be kept or omitted

#### Examples:
| Requested numbers | Entered password |
| -- | -- |
| `001` | `1xN4P sv5f` _(or `1xN4Psv5f`)_ |
| `000/001/002` | `1S33m 8:z9xN4P sv5fBUUZ DzYQ` _(or `1S33m8:z9xN4Psv5fBUUZDzYQ`)_ |

## References
 * [OTPW guide](https://www.digitalocean.com/community/tutorials/install-and-use-otpw)
