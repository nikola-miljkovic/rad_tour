import {TourListing} from "./TourListing";
import {User} from "./User";

export interface AppState {
    user: User,
    tourListing: Array<TourListing>,
}