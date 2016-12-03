import * as React from "react";
import { bindActionCreators } from "redux";
import { ActionLink } from "./ActionLink";
import { User } from "../models/User";
import {connect} from "react-redux";
import {AppState} from "../models/AppState";
import {checkUser} from "../userActions";

export interface StateProps {
    user?: User
}

export interface DispatchProps {
    checkUser(): any
}

type NavbarProps = StateProps & DispatchProps;

function mapDispatchToProps(dispatch: any): DispatchProps {
    return {
        checkUser: bindActionCreators(checkUser, dispatch)
    }
}

function mapStateToProps(state: AppState): StateProps {
    return {
        user: state.user,
    };
}

function getContentForUser(user: User) {
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

class NavbarComponent extends React.Component<NavbarProps, {}> {
    render() {
        let user = this.props.user;
        let navbarContent = getContentForUser(user);
        
        return (
            <div className="header">
                <button onClick={this.props.checkUser}>"Pozdrav"</button>
                {navbarContent}
                <span className="logo"/>
            </div>
        );
    }
}

const Navbar = connect(mapStateToProps, mapDispatchToProps)(NavbarComponent);
export default Navbar;