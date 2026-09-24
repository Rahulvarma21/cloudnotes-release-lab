# Release Notes — CloudNotes Release Lab

Fill in this template as you diagnose and fix each of the three planted faults.

## Task 1 — Terraform/HCL validation fault

**Original error (paste `terraform validate` output):**

```
<paste here>
terraform -chdir=terraform validate

╷
│ Error: Reference to undeclared input variable
│ 
│   on main.tf line 33, in resource "local_file" "release_manifest":
│   33:     bucket      = var.bucket_name_old
│ 
│ An input variable with the name "bucket_name_old" has not been declared. This variable can be declared with a variable
│ "bucket_name_old" {} block.
╵
```

**Root cause:**

The error message indicates that the variable `bucket_name_old` is being used in the `main.tf` file but has not been declared.
**Fix applied:**

The fix involves replacing the reference to the undeclared variable `var.bucket_name_old` with the correct variable `var.bucket_name` in the `main.tf` file.

**Evidence (clean validate output):**

```
<paste here>
terraform -chdir=terraform validate
Success! The configuration is valid.
```

---

## Task 2 — Reusable module + state isolation fault

**Original problem:**

<describe what was duplicated / misconfigured>
in the staging/backend.hcl file the path was pointing to the dev/terraform.tfstate
# This should point at its own state file, isolated from dev.
path = "envs/dev/terraform.tfstate"

**Fix applied:**

<describe the change — module call + unique backend paths>
# This should point at its own state file, isolated from dev.
path = "envs/staging/terraform.tfstate"

**Evidence:**

```
<paste here>
```

---

## Task 3 — Container build + secret fault

**Original error (paste `docker build` output):**

```
<paste here>
docker build -t cloudnotes-api:0.1.0 .

[+] Building 54.4s (11/11) FINISHED                                                                                                                          docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                                         0.1s
 => => transferring dockerfile: 834B                                                                                                                                         0.0s
 => [internal] load metadata for docker.io/library/node:20-alpine                                                                                                            5.4s
 => [internal] load .dockerignore                                                                                                                                            0.2s
 => => transferring context: 105B                                                                                                                                            0.0s
 => [deps 1/4] FROM docker.io/library/node:20-alpine@sha256:fb4cd12c85ee03686f6af5362a0b0d56d50c58a04632e6c0fb8363f609372293                                                10.0s
 => => resolve docker.io/library/node:20-alpine@sha256:fb4cd12c85ee03686f6af5362a0b0d56d50c58a04632e6c0fb8363f609372293                                                      0.4s
 => => sha256:cd322d0ddd02673e6c24a2158d1f12f6ec7c6fd9c0dc67123244d0f0eb0f8806 0B / 443B                                                                                    46.4s
 => => sha256:13e45b12880fbbfe3554ecf6b70131ace701d0c2fd3e2fb9abb842ba2494cd40 1.26MB / 1.26MB                                                                               0.8s
 => => sha256:bda5d7ef971f8ede8ea80002d2ac886ef6807fe32cfe46c38704a7ba0429475d 43.55MB / 43.55MB                                                                             4.6s
 => => sha256:d17f077ada118cc762df373ff803592abf2dfa3ddafaa7381e364dd27a88fca7 4.20MB / 4.20MB                                                                               4.5s
 => => extracting sha256:d17f077ada118cc762df373ff803592abf2dfa3ddafaa7381e364dd27a88fca7                                                                                    0.4s
 => => extracting sha256:bda5d7ef971f8ede8ea80002d2ac886ef6807fe32cfe46c38704a7ba0429475d                                                                                    2.7s
 => => extracting sha256:13e45b12880fbbfe3554ecf6b70131ace701d0c2fd3e2fb9abb842ba2494cd40                                                                                    0.1s
 => => extracting sha256:cd322d0ddd02673e6c24a2158d1f12f6ec7c6fd9c0dc67123244d0f0eb0f8806                                                                                    0.0s
 => [internal] load build context                                                                                                                                            2.2s
 => => transferring context: 2.42MB                                                                                                                                          1.9s
 => [deps 2/4] WORKDIR /app                                                                                                                                                  0.6s
 => [deps 3/4] COPY app/package.json ./                                                                                                                                      0.2s
 => [deps 4/4] RUN npm install --omit=dev                                                                                                                                   28.2s
 => [runtime 3/4] COPY --from=deps /app/node_modules ./node_modules                                                                                                          0.4s 
 => [runtime 4/4] COPY app/ ./                                                                                                                                               1.5s 
 => exporting to image                                                                                                                                                       6.1s 
 => => exporting layers                                                                                                                                                      4.3s 
 => => exporting manifest sha256:39a94e52606ecc8704f5a0c68c2806fe9e2b3344ba1f1e04d162451d4873c750                                                                            0.1s 
 => => exporting config sha256:48dd3f75a700bf941dce92f34541b947a42759afeb808ab56d5896832efe7410                                                                              0.0s 
 => => exporting attestation manifest sha256:126b797b17750fb4752a10f21e35c1bf49b641b7487ee7149c934f452184f2fa                                                                0.2s
 => => exporting manifest list sha256:74a78dd4d1596498562bf451ba8af4de58796c89d0afaeb9c652e4827faa8ca6                                                                       0.1s
 => => naming to docker.io/library/cloudnotes-api:0.1.0                                                                                                                      0.0s
 => => unpacking to docker.io/library/cloudnotes-api:0.1.0                                                                                                                   1.1s

 1 warning found (use docker --debug to expand):
 - SecretsUsedInArgOrEnv: Do not use ARG or ENV instructions for sensitive data (ENV "API_KEY") (line 20)
```

**Root cause:**

<explain>
# NOTE: this should copy from the "deps" stage, not "build" (no such stage
# exists in this Dockerfile).
COPY --from=build /app/node_modules ./node_modules
COPY app/ ./

**Fix applied:**
# NOTE: this should copy from the "deps" stage, not "build" (no such stage
# exists in this Dockerfile).
COPY --from=deps /app/node_modules ./node_modules
COPY app/ ./

<describe the Dockerfile / compose changes>

**Evidence (`curl http://localhost:8080/health`):**

```
<paste here>
curl http://localhost:8080/health
{"status":"ok","service":"cloudnotes-api","version":"0.1.0","apiKeyConfigured":true}%         
```
