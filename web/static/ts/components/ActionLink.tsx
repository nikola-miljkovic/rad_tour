import * as React from "react";
import { getCRSF } from "../helpers";

export interface ActionLinkProps {
    method: string;
    action: string;
}

export class ActionLink extends React.Component<ActionLinkProps, {}> {
    private  _form: any;

    submit() {
        this._form.submit();
    }

    render () {
        return (
            <form 
                className="link" 
                action={this.props.action}
                method="POST"
                ref={(f) => this._form = f}
            >
                <input type="hidden" name="_method" value={this.props.method} />
                <input type="hidden" name="_csrf_token" value={getCRSF()} />
                <a href="#" onClick={() => this.submit()}>
                    {this.props.children}
                </a>
            </form>
        )
    }
}