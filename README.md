# distrokiln &nbsp; [![bluebuild build badge](https://github.com/firekind/distrokiln/actions/workflows/build.yml/badge.svg)](https://github.com/firekind/distrokiln/actions/workflows/build.yml)

Personal [BlueBuild](https://blue-build.org/) images, one recipe per host.

| Host       | Image                                  | Base                 |
| :--------- | :------------------------------------- | :------------------- |
| `nyohhira` | `ghcr.io/firekind/distrokiln/nyohhira` | Fedora Silverblue 44 |

## Installation

To rebase an existing atomic Fedora installation onto one of these images:

- First switch to the unsigned image, to get the signing keys and policies installed:
  ```
  bootc switch ghcr.io/firekind/distrokiln/nyohhira:44
  ```
- Reboot to complete the switch:
  ```
  systemctl reboot
  ```
- Then switch to the signed image:
  ```
  bootc switch --enforce-container-sigpolicy ghcr.io/firekind/distrokiln/nyohhira:44
  ```
- Reboot again to complete the installation:
  ```
  systemctl reboot
  ```

Clear any layered packages with `rpm-ostree reset` before switching, or they'll
conflict with what's already in the image.

### Tags

| Tag                       | Tracks                                                        |
| :------------------------ | :------------------------------------------------------------ |
| `44`                      | Latest build on Fedora 44 — no accidental major-version jumps |
| `latest`                  | Latest build, whatever Fedora version the recipe specifies    |
| `20261102`, `20261102-44` | Dated snapshots                                               |
| `<short-sha>-44`          | A specific commit's build                                     |

Fedora releases are bumped deliberately: change `image-version` in the recipe,
push, then switch to the new tag.

## ISO

An offline ISO can be generated on Fedora Atomic following
[these instructions](https://blue-build.org/how-to/generate-iso/#_top). For a
fresh machine it's usually simpler to install stock Silverblue and then switch.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s
[cosign](https://github.com/sigstore/cosign). Verify with the `cosign.pub` in
this repo:

```bash
cosign verify --key cosign.pub ghcr.io/firekind/distrokiln/nyohhira
```
