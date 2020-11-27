$(function () {
  $(".hleague_slider").bxSlider({
    minSlides: 2, // 반응형일때 minSlides이용
    maxSlides: 4, // 최대 slides보여지는수
    slideWidth: 250, // 크기 나타냄
    slideMargin: 30, // 슬라이드 간격
    moveSlides: 1, // 슬라이드 1개씩 움직인다
    auto: true, // 이동하기
    speed: 500, // 이동속도
    pause: 5000, //이동시간
    pager: true,
  });
});
$;
