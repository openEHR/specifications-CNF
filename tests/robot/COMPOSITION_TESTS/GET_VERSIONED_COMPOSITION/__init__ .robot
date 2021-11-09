# Copyright (c) 2021 Jake Smolka (Hannover Medical School),
#                    Wladislaw Wagner (Vitasystems GmbH),
#                    Pablo Pazos (Hannover Medical School).
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
Metadata    Version    1.0
Metadata    Authors    *Jake Smolka*, *Wladislaw Wagner*
Metadata    Created    2019.02.26
Metadata    Updated    2021.06.10

Documentation          https://github.com/ehrbase/ehrbase/blob/develop/doc/conformance_testing/EHR_COMPOSITION.md#b5-get-versioned-composition
...                    https://wiki.vitagroup.ag/display/ETHERCIS/Versioned+COMPOSITION

Resource   ${EXECDIR}/robot/_resources/suite_settings.robot

# Suite Setup    startup SUT
# Suite Teardown    shutdown SUT

Force Tags    COMPOSITION_get_versioned
