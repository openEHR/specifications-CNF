# Copyright (c) 2019 Wladislaw Wagner (Vitasystems GmbH), Pablo Pazos (Hannover Medical School).
#
# This file is part of Project EHRbase
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



*** Settings ***
Metadata    Version    0.1.0
Metadata    Authors    *Wladislaw Wagner*, *Pablo Pazos*
Metadata    Created    2019.03.03

Documentation   I_EHR_SERVICE.has_ehr-existing_ehr_id: Check has EHR with existing EHR
Metadata        TOP_TEST_SUITE    EHR_SERVICE

Resource        ../../_resources/keywords/ehr_keywords.robot

# Suite Setup  startup SUT
# Suite Teardown  shutdown SUT

Force Tags    refactor



*** Test Cases ***
Check has EHR with existing EHR

    prepare new request session    JSON    Prefer=return=representation
    create new EHR
    retrieve EHR by ehr_id
    Verification: Response Should Contain Correct Values



*** Keywords ***
Verification: Response Should Contain Correct Values
    [Documentation]     Verifies that returned properties in response's body
    ...                 have correct values:
    ...                 1) `ehr_id` is correct
    ...                 2) `system_id` have to be equal to the one when EHR was created
    ...                 3) `is_queryable` is true
    ...                 4) `is_modifiable` is true

    check content of retrieved EHR (JSON)
