import * as React from "react";
import * as ReactDOM from "react-dom";

import { getContent } from "./helpers";
import { Navbar } from "./components/Navbar";

var navbarData = getContent('_navbarData');

ReactDOM.render(
    <Navbar user={navbarData} />,
    document.getElementById("header")
)