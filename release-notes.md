# Release Notes — CloudNotes Release Lab

Fill in this template as you diagnose and fix each of the three planted faults.

## Task 1 — Terraform/HCL validation fault

**Original error (paste `terraform validate` output):**

```
<paste here>
```

**Root cause:**

<explain>

**Fix applied:**

<describe the change>

**Evidence (clean validate output):**

```
<paste here>
```

---

## Task 2 — Reusable module + state isolation fault

**Original problem:**

<describe what was duplicated / misconfigured>

**Fix applied:**

<describe the change — module call + unique backend paths>

**Evidence:**

```
<paste here>
```

---

## Task 3 — Container build + secret fault

**Original error (paste `docker build` output):**

```
<paste here>
```

**Root cause:**

<explain>

**Fix applied:**

<describe the Dockerfile / compose changes>

**Evidence (`curl http://localhost:8080/health`):**

```
<paste here>
```
