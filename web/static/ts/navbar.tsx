import * as React from "react";
import * as ReactDOM from "react-dom";

import { getContent } from "./helpers";
import { Navbar } from "./components/Navbar";
import { User } from "./models/User";

document.addEventListener('turbolinks:load', function () {
    let user = getContent('_navbarData') as User;

    ReactDOM.render(
        <Navbar user={user}/>,
        document.getElementById("header")
    )
});