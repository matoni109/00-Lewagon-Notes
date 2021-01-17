https: //glitch.com/edit/#!/foam-joyous-kettle?path=public%2Findex.html%3A29%3A0
    https: //stimulusjs.org/handbook/building-something-real

    ##https: //developer.yr.no/doc/GettingStarted/
    https: //leafletjs.com/ maps

    class User {
        // TODO: your code!
        constructor(firstName, lastName) {
            this.firstName = firstName;
            this.lastName = lastName;
        }
        get fullName() {
            return this.fullName();
        }

        fullName() {
            return `${this.firstName} * ${this.lastName}`;
        }

    }

class Rectangle {
    constructor(height, width) {
        this.height = height;
        this.width = width;
    }
    // Getter
    get area() {
        return this.calcArea();
    }
    // Method
    calcArea() {
        return this.height * this.width;
    }
}


// lib/controllers/zelda_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ["trigger"];

    connect() {
        console.log("The Zelda controller is now loaded!");
        this.originalTriggerText = this.triggerTarget.innerText;
    }

    play() {
        console.log("Button clicked! TODO: play a sound");
        const sound = new Audio(this.data.get('sound'));
        sound.play();
        console.log(this.triggerTarget);
        this.triggerTarget.innerText = "Bingo!";
        this.triggerTarget.setAttribute('disabled', '');
        sound.addEventListener("ended", () => {
            this.triggerTarget.removeAttribute('disabled');
            this.triggerTarget.innerText = this.originalTriggerText;

        });
    }
}


import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";

const application = Application.start();
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

// The rest of the code with document.querySelector('#clickme');