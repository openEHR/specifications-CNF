# AGENTS.md

Guidance for AI coding agents working in **specifications-CNF**.

## What this repo is

`specifications-CNF` is the **document source** for the openEHR **CNF** (Conformance Specifications) component. It is a *specification* repo, not software: the deliverables are the HTML specs at https://specifications.openehr.org/releases/CNF/. Sources are **AsciiDoc** prose; the committed `docs/*.html` files are build artefacts.

`manifest.json` is the source of truth for which documents exist, their `spec_status`, releases, and the `SPECCNF` Jira roadmap. Published documents: `guide`, `platform_test_schedule`, `profiles`, `certificate`.

CNF defines how an openEHR platform is shown to conform: the Conformance Guide (the approach and vocabulary), the Platform Conformance Test Schedule (the test cases, organised by the service interfaces of the SM component), Platform Profiles (which parts a product claims) and the Conformance Certificate. It builds on SM (the abstract service model the test cases are organised by), ITS-REST (the concrete API the tests are run against) and RM/AM/QUERY for the data, models and queries used in test cases.

## Layout

- `docs/<document>/master.adoc` plus `masterNN-*.adoc` chapters (`master00` = amendment record); `manifest_vars.adoc` is generated from `manifest.json` on publish.
- `.asciidoctorconfig` — attributes for editor previews (`:component:`, `:imagesdir:`).

<!-- openehr-scaffold:begin plugin -->
## Use the `openehr-specs@openehr` plugin

The plugin carries the spec-authoring know-how — **prefer its skills/agents over ad-hoc edits.** Don't re-derive their workflows here. `.claude/settings.json` registers the `openehr` marketplace and enables the plugin; Claude Code asks you to trust the folder first. To install it by hand: `/plugin marketplace add openEHR/ai-plugins`, then `/plugin install openehr-specs@openehr`.

| Task | Use |
|------|-----|
| Create/edit a spec, chapter, `master.adoc`, or `manifest.json` | skill `openehr-specs:authoring` |
| Spec prose style — overviews, semantics, design rationale | skill `openehr-specs:content-patterns` |
| Amendment record (`master00-amendment_record.adoc`) | skill `openehr-specs:amendment-record` |
| Releases, CR/PR, lifecycle status, Jira workflow | skill `openehr-specs:governance` |
| Quality / convention review of a document | skill `openehr-specs:review` |
| Whole-document convention review (all chapters) | agent `openehr-specs:spec-reviewer` |
| Fact-check class/attribute/function names in prose | agent `openehr-specs:identifier-grounding` |
| Audit `{openehr_*}` attributes + `<<anchor>>` cross-refs | agent `openehr-specs:xref-auditor` |
| Local HTML preview of this component (you run it) | `/openehr-specs:publish CNF` |
| Check this repo against the standard file set | `/openehr-specs:scaffold` |
<!-- openehr-scaffold:end plugin -->

<!-- openehr-scaffold:begin build -->
## Build tool invocation

Docker is all you need to render the documents. All `specifications-XX` repos, including `specifications-AA_GLOBAL` (boilerplate, references), are cloned as siblings under one parent directory. Render from that parent directory:

```bash
# render HTML. The image is published from specifications-AA_GLOBAL; its entrypoint passes -q
# (package-qualified class files). Use `Release-X.Y.Z` instead of `development` for a release build.
docker run --rm -u $(id -u):$(id -g) -v "$PWD:/documents/" ghcr.io/openehr/asciidoctor development CNF
```

The build prints `generated <file>` and exits 0 even when includes are missing, so read the log: any `ERROR` or `include file not found` line means incomplete output. It also rewrites the tracked `docs/*.html` artefacts.
<!-- openehr-scaffold:end build -->

## Conformance test suite (`tests/`)

`tests/` is a Robot Framework suite that executes the Platform Conformance Test Schedule against a running openEHR REST server, originally contributed from the EHRbase project. It is not part of the document build.

- `tests/platform/robot/<INTERFACE>/` holds the test cases, one directory per SM service interface (`I_EHR_SERVICE`, `I_EHR_COMPOSITION`, `I_QUERY_SERVICE`, ...); `_resources/` holds shared keywords, test data and templates.
- `tests/requirements.txt` pins the Python dependencies (Robot Framework 4, RESTinstance, requests, database libraries); install into a virtualenv before running.
- `tests/run_local_tests.sh` runs the suite with `robot` against a local server; `tests/Taskfile.yml` (go-task) starts and stops an EHRbase-plus-PostgreSQL system under test in Docker; `dbclean.sh`, `dbtruncate.sh` and `restart_db.sh` reset that database. The server URL and credentials come from environment variables read in `_resources/`.
- `scripts/openehr_platform/tc_*.txt` are the plain-text test-case descriptions that the Test Schedule document is written from; keep them and the Robot tests in step.

One test file name contains a line break (`...get_composition_version-bad_ehr<LF>.robot`); it cannot be checked out on Windows and shows as deleted there. Do not commit that deletion.

<!-- openehr-scaffold:begin conventions -->
## Conventions

### Commit messages

- **Format:** `Changes for <KEY> - <what changed>`, one line, for example `Changes for SPECCNF-42 - fix typos in the overview chapter`. Say what changed in the specification, not which file.
- **Several tickets:** join the numbers, `Changes for SPECCNF-49/50 - <what changed>`.
- **Every commit that has a Jira ticket carries its key.** Take it from, in order: the user, the branch name (`feat/SPECCNF-42-<slug>`), or the Jira issue the task links to (the `atlassian-openehr` MCP server can look an issue up). Never invent or guess a key.
- **Which key:** `SPECCNF` for this component (change requests), `SPECPR` for problem reports, `SPECPUB` for publishing and tooling issues, or the owning component's key (`SPECAM`, `SPECRM`, ...) when the change belongs there. See skill `openehr-specs:governance`.
- **No ticket:** write a plain summary without a key and say so in the pull request; do not use a placeholder key.
- Some history, mostly in other components, puts the key last, `<what changed> (SPECCNF-42)`. It is understood, but use the leading form here.
- A change to published specification text also needs an amendment-record entry with the same ticket (skill `openehr-specs:amendment-record`).
- Do not stage regenerated `docs/*.html` or generated class tables together with source changes unless the task is to refresh them.

### Branches

- Branch from `master` as `feat/<KEY>-<slug>` or `fix/<KEY>-<slug>`, for example `feat/SPECCNF-42-template-id`, and merge to `master` by pull request.
<!-- openehr-scaffold:end conventions -->
