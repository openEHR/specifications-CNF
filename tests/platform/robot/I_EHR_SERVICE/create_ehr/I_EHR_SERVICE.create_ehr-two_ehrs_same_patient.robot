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
Metadata    Created    2020.01.30

Documentation   I_EHR_SERVICE.create_ehr-two_ehrs_same_patient: Create two EHRs for the same patient
Metadata        TOP_TEST_SUITE    EHR_SERVICE

Resource        ../../_resources/keywords/ehr_keywords.robot

# Suite Setup  startup SUT
# Suite Teardown  shutdown SUT

Force Tags    refactor



*** Test Cases ***
Create Same EHR Twice For The Same Patient (JSON)

    prepare new request session    JSON

    generate random subject_id
    create new EHR for subject_id (JSON)    ${subject_id}

    create new EHR for subject_id (JSON)    ${subject_id}

    verify response



*** Keywords ***
verify response
    Integer    response status    409

    # TODO: response should indicate a conflict with an already existing EHR with the same subject id, namespace pair.
