import * as React from "react";

import { ActionLink } from "./ActionLink";
import { User } from "../models/User";

export interface NavbarProps {
    user?: User
}

export class Navbar extends React.Component<NavbarProps, {}> {

    static getNavbarContent(user: any) {
        if (user == null) {
            return (
                <ol className="breadcrumb text-right">
                    <li><a href="/sign-up">Register</a></li>
                    <li><a href="/sessions/new">Log In</a></li>
                </ol>
            );
        } else {
            return (
                <ol className="breadcrumb text-right">
                    <li>{user.first_name}</li>
                    <li>
                        <ActionLink method="DELETE" action={"/sessions/" + user.id}>
                            Log Out
                        </ActionLink>
                    </li>
                    {
                        user.tour_guide != null ?
                        (<li>
                            <a href="/guides/edit">Edit Tour Guide Profile</a>
                        </li>)
                        :
                        null
                    }
                </ol>
            );
        }
    }
    
    render() {
        let user = this.props.user;
        let navbarContent = Navbar.getNavbarContent(user);
        
        return (
            <div className="header">
                {navbarContent}
                <span className="logo"/>
            </div>
        );
    }
}