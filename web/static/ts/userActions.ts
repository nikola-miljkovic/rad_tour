import { createAction, handleActions } from "redux-actions";
import {User} from "./models/User";
import {Action} from "./models/Action";
import {AppState} from "./models/AppState";
import * as R from "ramda";

export const ACTION_CHECK_USER = "ACTION_CHECK_USER";

export const checkUser = createAction<User>(
    ACTION_CHECK_USER
);

const defaultState: AppState = { user: null, tourListing: null };

export const userReducer = handleActions<AppState>({
    [ACTION_CHECK_USER]: (state: AppState, action: Action): AppState => {
        return state;
    }
}, defaultState);