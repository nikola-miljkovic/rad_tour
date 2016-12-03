import * as React from "react";
import * as ReactDOM from "react-dom";
import { Provider } from 'react-redux'
import store from "./store";
import Navbar from "./components/Navbar";

document.addEventListener('turbolinks:load', function () {

    const App: React.StatelessComponent<any> = () => (
        <Provider store={store}>
            <Navbar />
        </Provider>
    );

    ReactDOM.render(
        <App />,
        document.getElementById("header")
    )

});