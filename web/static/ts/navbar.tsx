import * as React from "react";
import * as ReactDOM from "react-dom";
import { Provider } from 'react-redux'
import store from "./store";
import Navbar from "./components/Navbar";

document.addEventListener('turbolinks:load', function () {

    ReactDOM.render(
        <Provider store={store}>
            <Navbar />
        </Provider>,
        document.getElementById("navbar")
    );

    if (store.getState().tourListing != null) {
        ReactDOM.render(
            <Provider store={store}>
                <TourListing />
            </Provider>,
            document.getElementById("tourListing")
        );
    }
});