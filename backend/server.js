const express = require("express");
const cors = require("cors");

const app = express();
const PORT = 3000;

app.use(cors());

app.get("/api/message", (req, res) => {
    res.json({
        message: "Version 1"
    });
});

app.listen(PORT, () => {
    console.log(`Backend running on port ${PORT}`);
});