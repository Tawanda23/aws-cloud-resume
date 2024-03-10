const counter = document.querySelector(".counter-number");
async function updateCounter() {
    let response = await fetch(
        "https://3bfjjelldc5c267cshehqz5rvq0bcssc.lambda-url.eu-west-2.on.aws/");
    let data = await response.json();
    counter.innerHTML = `Views: ${data}`;
}
updateCounter();