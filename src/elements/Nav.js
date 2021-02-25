import React from 'react'
import { Link } from 'react-router-dom'

import '../App.css'

function Contact() {
    const navStyle = {
        color: 'white'
    }

    return (
        <nav>
            <Link to="/" style={navStyle}><h3>The Projection Room</h3></Link>
            <ul className="nav-links">
                <Link to="/about" style={navStyle}><li>About</li></Link>
                <Link to="/contact" style={navStyle}><li>Contact</li></Link>
            </ul>
        </nav>
    )
}

export default Contact