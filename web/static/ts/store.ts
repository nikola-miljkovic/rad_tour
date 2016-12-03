import { createStore } from "redux";
import { User } from "./models/User";
import { getContent } from "./helpers";
import { TourListing } from "./models/TourListing";
import { userReducer } from "./userActions";
import { AppState } from "./models/AppState";

const USER_DATA = "_userData";
const TOUR_LISTING_DATA = "_tourListingData";

function loadApplicationState(): AppState {
    return {
        user: getContent<User>(USER_DATA),
        tourListing: getContent<TourListing[]>(TOUR_LISTING_DATA)
    }
}

let store = createStore<AppState>(userReducer, loadApplicationState());

export default store;