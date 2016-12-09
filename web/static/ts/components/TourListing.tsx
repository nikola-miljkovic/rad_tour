import * as React from "react";
import { bindActionCreators } from "redux";
import { connect } from "react-redux";
import { TourListing } from "../models/TourListing";
import {AppState} from "../models/AppState";

interface StateProps {
    tourListing: TourListing[]
}

interface DispatchProps {

}

type TourListingProps = StateProps & DispatchProps;

function mapStateToProps(state: AppState): StateProps {
    return {
        tourListing: state.tourListing,
    };
}

function mapDispatchToProps(state: AppState): DispatchProps {
    return {
    };
}

class TourListingComponent extends React.Component<TourListingProps, {}> {

}

const TourListing = connect(mapStateToProps)(TourListingComponent);
export default TourListing;