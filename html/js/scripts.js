// question variables
var questionNumber = 1;
var answers = [];

var router = [];
router.history = [];

router.push = function(route) {
	$(".nav-link").removeClass("active");
	$(".page-section").hide();


	$("#nav-" + route).addClass("active");
	$("#section-" + route).show();
	router.history.push(route);
}

router.back = function() {
	$(".nav-link").removeClass("active");
	$(".page-section").hide();

	router.history.pop()
	let route = router.history[router.history.length - 1]

	$("#nav-" + route).addClass("active");
	$("#section-" + route).show();
}

router.isOn = function(route) {
	return (router.history[router.history.length - 1] == route);
}

function getNewFormation(infos) {
	let html = `<div class="col-3 mb-3">
					<div class="card">
						<img src="_image" class="card-img-top" alt="">
						<div class="card-body">
							<h5 class="card-title">_title</h5>
							<p class="card-text">_description</p>
						</div>
						<ul class="list-group list-group-flush">
							<li class="list-group-item">Prix: _price</li>
						</ul>
						<div class="card-body">
							<button class="btn btn-primary start-formation" data-type="_type" _disabled>Passer la formation</button>
						</div>
					</div>
				</div>`
	console.log("posseded: ", infos.disabled)
	html = html.replace("_image", infos.path)
				.replace("_title", infos.title)
				.replace("_description", infos.description)
				.replace("_type", infos.type)
				.replace("_disabled", (infos.disabled) ? "disabled" : "")
				.replace("_price", infos.price)

	return html;
}


// Listen for NUI Events
window.addEventListener('message', function (event) {
	var item = event.data;

	if (item.action == "open") {
		if (item.formations) {
			let container = $("#formation-container")
			container.html("");
			item.formations.forEach(el => {
				container.append(getNewFormation(el));
			});
		}

		router.push("home");
		$(".main-container").show();
	}

	if (item.action == "start") {
		startTest(item.type);
	}

	if (item.action == "close") {
		$(".main-container").hide();
	}
});

$("#nav-home").on("click", function() {
	if (router.isOn("question") || router.isOn("result"))
		return;
	router.push("home");
});

$("#nav-work").on("click", function() {
	if (router.isOn("question") || router.isOn("result"))
		return;
	router.push("work");
});

$("#nav-form").on("click", function() {
	if (router.isOn("question") || router.isOn("result"))
		return;
	router.push("form");
});

$(".btn-response").on("click", function() {
	$(".btn-response").removeClass("btn-primary").addClass("btn-secondary");
	$(this).removeClass("btn-secondary").addClass("btn-primary");
	$(".btn-next").show();
})

$("#close-btn2").click(function () {

	$(".main-container").hide();
	$.post('https://qb-driverschool/close');
});

$("#close-btn").click(function () {
	if (router.isOn("question"))
		return;

	$(".main-container").hide();
	$.post('https://qb-driverschool/close');
});

function getRandomQuestion() {
	var random;

	do {
		random = Math.floor(Math.random() * Configs.questions.length);
	} while (answers[random])

	return random;
}

function startTest(type) {
	if (type == "N") {
		answers = [];
		questionNumber = 0;
		nextQuestion();
		router.push("question");
	} else {
		$.post('https://qb-driverschool/startTest', JSON.stringify({ type }));
	}
}

function nextQuestion() {
	var id = getRandomQuestion();
	var question = Configs.questions[id];

	$("#section-question").data("id", id);
	$("#question_title").html(question.title);
	if (question.responses[0])
		$("#response-a").html("<strong>A)</strong> " + question.responses[0].title);

	if (question.responses[1])
		$("#response-b").html("<br /><strong>B)</strong> " + question.responses[1].title);
	if (question.responses[2])
		$("#response-c").html("<br /><strong>C)</strong> " + question.responses[2].title);
	if (question.responses[3])
		$("#response-d").html("<br /><strong>D)</strong> " + question.responses[3].title);
}

function endTest() {
	let score = 0;
	answers.forEach((val, key) => {
		let question = Configs.questions[key];
		score += (question.responses[val].type) ? 1 : 0;
	});

	router.push('result');
	$("#test-result").html(score + "/" + Configs.nbQuestionToAnswer);

	if (score >= Configs.neededPoint) {
		$("#result-text").html("FAVORABLE").css("color", "#2d9e00")
		$.post('https://qb-driverschool/give');
	} else {
		$("#result-text").html("INSUFFISANT").css("color", "#b80f00")
	}
}


$(".btn-next").on("click", function() {
	let id = $("#section-question").data("id");
	answers[id] = $(".btn-response.btn-primary").data("value");
	questionNumber++;
	$(".btn-response").removeClass("btn-primary").addClass("btn-secondary");
	$(".btn-next").hide();

	(questionNumber < Configs.nbQuestionToAnswer) ? nextQuestion() : endTest();
})

$("#formation-container").on("click", ".start-formation", function() {
	var type = $(this).data("type");
	$.post('https://qb-driverschool/payTest', JSON.stringify({ type }));
})