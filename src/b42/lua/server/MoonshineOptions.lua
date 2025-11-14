--
-- Copyright (c) 2025 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

function MoonshineStillBuildEnabled(param)
    return SandboxVars.Permanent.CanBuildMoonshineStill or isAdmin();
end
