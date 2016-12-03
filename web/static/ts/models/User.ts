import {TourGuide} from "./TourGuide";

export interface User {
    id:             number,
    first_name:     string,
    tour_guide?:    TourGuide
}