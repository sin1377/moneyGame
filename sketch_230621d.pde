import java.util.stream.IntStream;
import java.util.List;

int month = 1, date = 1, stonk = 0, second, firstFrame, a, b, c;
int[] month_31 = {1, 3, 5, 7, 8, 10, 12}, month_30 = {4, 6, 9, 11};
boolean nextDayButtonPressed, mainScreen = true, bankUI, stonkUI, casinoUI, gameEndUI, start = true, bgline = true, countDown = true, firstNum, secondNum, thirdNum, casinoButtonPressed, moneyGived, stonkorCasinoButtonAvailable = true;
ArrayList<Boolean> moneyGame = new ArrayList<Boolean>();
float money = 10000, savings, speed = 5, A = 20, smoney, x, nr, n1;

void setOnlyOneTrue(List<Boolean> list, int index) { //입력받은 리스트의 boolean값 중 입력받은 인덱스의 변수만만 true로 바꾸고 나머지는 false로 바꾸는 함수
  if (index >= list.size()) {
    return;
  }
  for (int i = 0; i < list.size(); i++) {
    list.set(i, (i == index) ? true : false);
  }
}

void setup() {
  fullScreen();
  rectMode(CENTER);
  background(255);
  moneyGame.add(mainScreen); //moneyGame.get(0) = mainScreen
  moneyGame.add(bankUI); //moneyGame.get(1) = bankUI
  moneyGame.add(stonkUI); //moneyGame.get(2) = stonkUI
  moneyGame.add(casinoUI); //moneyGame.get(3) = casinoUI
  moneyGame.add(gameEndUI); //moneyGame.get(4) = gameEndUI
  n1 = height/2;
}

void mainUI() { //메인화면의 UI
  background(255);
  strokeWeight(1);
  if (date == 1) {
  fill(#00FF00);
  } else {
    fill(170);
  }
  rect(width/4, height/2 + height/4, width/6, height/6);
  if (stonkorCasinoButtonAvailable && money >= 2000) {
  fill(#FFFF00);
  } else {
    fill(170);
  }
  rect(width/2, height/2 + height/4, width/6, height/6);
  if (stonkorCasinoButtonAvailable && money >= 200) {
  fill(#FF0000);
  } else {
    fill(170);
  }
  rect(width*3/4, height/2 + height/4, width/6, height/6);
  textAlign(LEFT, CENTER);
  fill(0);
  textSize(50);
  text("Today : " + month + "/" + date, width/50, height/20);
  textAlign(CENTER, CENTER);
  text("BANK", width/4, height/2 + height/4);
  text("STONK", width/2, height/2 + height/4);
  text("CASINO", width*3/4, height/2 + height/4);
  fill(70);
  rect(width/12, height/7, width/6, height/10);
  fill(255);
  textSize(70);
  text("NEXT DAY", width/12, height/7);
  fill(0);
  textSize(200);
  text("MONEY\nGAME", width/2, height/3);
  textAlign(RIGHT, CENTER);
  textSize(70);
  text("money : " + money + "$", width - height/20, height/20);
  textAlign(CENTER, CENTER);
}

void draw() {
  if (moneyGame.get(0)) {
    if (!nextDayButtonPressed) {
      mainUI();
      bank();
      stonk();
      casino();
    }
    nextDayButton();
  }
  if (moneyGame.get(1)) {
    bankUI();
  }
  if (moneyGame.get(2)) {
    stonkUI();
  }
  if (moneyGame.get(3)) {
    casinoUI();
  }
  if (moneyGame.get(4)) {
    gameEnd();
  }
}

void nextDayButton() { //메인화면의 NEXT DAY 버튼을 누른 것을 감지하는 함수
  if (mouseX >= 0 && mouseX < width/6 && mouseY > height/7 - height/20 && mouseY < height/7 + height/20 && mousePressed && !nextDayButtonPressed) {
    nextDayButtonPressed = true;
    nextDayButtonUI();
  }
  if (nextDayButtonPressed) { //다음날로 가겠냐는 Yes와 No 버튼을 감지하는 함수
    if (mouseX > width * 7/24 && mouseX < width * 11/24 && mouseY > height * 9/16 - height/6 && mouseY < height * 11/16 - height/6 && mousePressed) {
      date ++;
      stonkorCasinoButtonAvailable = true;
      casinoButtonPressed = false;
      moneyGived = false;
      nextDayButtonPressed = false;
    }
    if (mouseX > width * 13/24 && mouseX < width * 17/24 && mouseY > height * 9/16 - height/6 && mouseY < height * 11/16 - height/6 && mousePressed) {
      nextDayButtonPressed = false;
    }
    int finalday = IntStream.of(month_31).anyMatch(x -> x == month) ? 31 : IntStream.of(month_30).anyMatch(x -> x == month) ? 30 : 28; //날짜 변경 함수
    if (date > finalday) {
      month ++;
      date = 1;
      if (month > 12) {
        setOnlyOneTrue(moneyGame, 4);
      } else {
        money += 3000;
        savings *= 1.1;
      }
    }
  }
}

void nextDayButtonUI() { //NEXT DAY 버튼 UI
  fill(255);
  rect(width/2, height/2 - height/6, width/2, height/2);
  fill(170);
  rect(width/2 - width/8, height/2 - height/6 + height/8, width/6, height/8);
  rect(width/2 + width/8, height/2 - height/6 + height/8, width/6, height/8);
  fill(0);
  textSize(50);
  text("YES", width/2 - width/8, height/2 - height/6 + height/8);
  text("NO", width/2 + width/8, height/2 - height/6 + height/8);
  text("Will You Skip to Next Day?", width/2, height/2.5 - height/6);
}

void gameEnd() { //12월 31일이 지났을 때 게임 종료를 나타내는 화면
  money += savings;
  savings = 0;
  background(255);
  fill(180);
  rect(width/2, height/2, width/2, height/2);
  fill(0);
  textSize(80);
  text("Game End\nYou Earned " + money + ".", width/2, height/2);
}

void bank() { //BANK 버튼을 누른 걸 감지하는 함수
  if (mouseX > width / 4 - width / 12 && mouseX < width / 4 + width / 12 && mouseY > height * 3 / 4 - height / 12 && mouseY < height * 3 / 4 + height / 12 && mousePressed && date == 1) {
    setOnlyOneTrue(moneyGame, 1);
  }
}

void bankUI() { //BANK 버튼을 눌렀을 때 나오는 화면 (UI + 기능)
  background(#FFEA90);
  fill(0);
  textSize(200);
  text("BANK", width/2, height/4);
  fill(#A6A6A6);
  if (mouseX >= width / 8 && mouseX <= width * 3 / 8 &&
    mouseY >= height * 5 / 8 && mouseY <= height * 7 / 8) {
    fill(#868686);
  } else {
    fill(#A6A6A6);
  }
  rect(width/4, height*3/4, width/4, height/4);
  fill(0);
  textSize(80);
  text("DEPOSIT", width/4, height*3/4);
  text("You can Deposit " + money + "$.", width/4, height*3/4 - height/5);
  if (mouseX >= width * 5 / 8 && mouseX <= width * 7 / 8 &&
    mouseY >= height * 5 / 8 && mouseY <= height * 7 / 8) {
    fill(#868686);
  } else {
    fill(#A6A6A6);
  }
  rect(width*3/4, height*3/4, width/4, height/4);
  fill(0);
  text("WITHDRAW", width*3/4, height*3/4);
  text("You can Withdraw " + savings + "$.", width*3/4, height*3/4 - height/5);
  textAlign(RIGHT, CENTER);
  textSize(70);
  text("money : " + money, width - height/20, height/20);
  textAlign(CENTER, CENTER);
  rect(width/12, height*13/280, width/6, height*13/140);
  fill(255);
  text("<-BACK", width/12, height*13/280);
  if (mouseX >= 0 && mouseX < width/6 && mouseY >= 0 && mouseY < height*13/140 && mousePressed) {
    setOnlyOneTrue(moneyGame, 0);
  }
}

void stonk() { //STONK 버튼을 누른 걸 감지하는 함수
  if (mouseX > width/2 - width/12 && mouseX < width/2 + width/12 && mouseY > height*3/4 - height/12 && mouseY < height*3/4 + height/12 && mousePressed && stonkorCasinoButtonAvailable && money >= 2000) {
    setOnlyOneTrue(moneyGame, 2);
    firstFrame = millis();
    smoney = money;
    stonkorCasinoButtonAvailable = false;
  }
}

void stonkUI() { //STONK 버튼을 눌렀을 때 나오는 화면 (UI + 기능)
  var stonkPrice = map(n1, 0, height, 1000, 2000);
  if (start) {
    if (bgline) {
      background(224);
      strokeWeight(3);
      stroke(100);
      for (int j = 0; j <= height; j += height/4) {
        line(0, j, width, j);
      }
      line(width/2, 0, width/2, height);
      strokeWeight(1);
      stroke(200);
      for (int i = 0; i <= height; i += height/40) {
        line(0, i, width, i);
      }
      bgline = false;
    }
    strokeWeight(1);
    fill(255, 100, 100);
    stroke(0);
    rect(width-250, height-120, 100, 40);
    rect(width-250, height-60, 100, 40);
    if ((mouseX < width-200 && mouseX > width-300) && ((mouseY < height-100 && mouseY > height-140) || (mouseY < height-40 && mouseY > height-80)) && !countDown) {
      if (mousePressed && (mouseButton == LEFT) && money > stonkPrice) {
        strokeWeight(3);
        stroke(255, 100, 100);
        line(x, height-n1, x, height-n1+100);
      }
      if (mouseY < height-100 && mouseY > height-140) {
        fill(255, 50, 50);
        rect(width-250, height-120, 100, 40);
        if (mousePressed && (mouseButton == LEFT) && money > stonkPrice) {
          stonk ++;
          money -= stonkPrice;
        }
      }
      if (mouseY < height-40 && mouseY > height-80) {
        fill(255, 50, 50);
        rect(width-250, height-60, 100, 40);
        if (mousePressed && (mouseButton == LEFT)) {
          while (money > stonkPrice) {
            stonk ++;
            money -= stonkPrice;
          }
        }
      }
    }
    strokeWeight(1);
    fill(100, 100, 255);
    stroke(0);
    rect(width-100, height-120, 100, 40);
    rect(width-100, height-60, 100, 40);
    if ((mouseX < width-50 && mouseX > width-150) && ((mouseY < height-100 && mouseY > height-140) || (mouseY < height-40 && mouseY > height-80)) && !countDown) {
      if (mousePressed && (mouseButton == LEFT) && stonk > 0) {
        strokeWeight(3);
        stroke(100, 100, 255);
        line(x, height-n1, x, height-n1+100);
      }
      if (mouseY < height-100 && mouseY > height-140) {
        fill(50, 50, 255);
        rect(width-100, height-120, 100, 40);
        if (mousePressed && (mouseButton == LEFT) && stonk > 0) {
          stonk --;
          money += stonkPrice;
        }
      }
      if (mouseY < height-40 && mouseY > height-80) {
        fill(50, 50, 255);
        rect(width-100, height-60, 100, 40);
        if (mousePressed && (mouseButton == LEFT) && stonk > 0) {
          while (stonk > 0) {
            stonk --;
            money += stonkPrice;
          }
        }
      }
    }
    fill(0);
    textSize(30);
    text("BUY", width-250, height-123);
    text("ALLBUY", width-250, height-63);
    text("SALE", width-100, height-123);
    textSize(25);
    text("ALLSALE", width-100, height-63);
  }
  if (countDown) {
    bgline = true;
    if (millis() - firstFrame >= 1000) {
      second ++;
      firstFrame = millis();
    }
    if (second < 3) {
      fill(0);
      textSize((1000-millis() + firstFrame)*0.18);
      text(3 - second, width/2, height/2);
    } else {
      countDown = false;
    }
  } else {
    strokeWeight(2);
    if (start) {
      var lowerBound = map(n1, 0, height, -0.0, -2.0);
      var upperBound = map(n1, 0, height, 2.0, 0.0);
      nr = random(lowerBound, upperBound) * A;
      if (nr > 0) {
        stroke(255, 0, 0);
      } else {
        stroke(0, 0, 255);
      }
      line(x, height-n1, x+speed, height-(n1+nr));
      x += speed;
      n1 = n1 + nr;
    }
    if (money < 0) {
      stonk --;
      money += stonkPrice;
    }
    stroke(0);
    if (x > width) {
      start = false;
      fill(255);
      rect(width/2, height/2, width/2, height/2);
      fill(100);
      rect(width/2, height*3/5, width/8, height/10);
      money += stonk * stonkPrice;
      stonk = 0;
      fill(0);
      textSize(50);
      if (money >= smoney) {
        text("Result : "+str(money-smoney)+"$ earn.", width/2, height/2);
      } else {
        text("Result : "+str(money-smoney)+"$ lose.", width/2, height/2);
      }
      fill(255);
      textSize(40);
      text("Left the Game.", width/2, height*3/5-5);
      if (mouseX < width*9/16 && mouseX > width*7/16 && mouseY < height*13/20 && mouseY > height*11/20) {
        fill(50);
        rect(width/2, height*3/5, width/8, height/10);
        fill(255);
        text("Left the Game.", width/2, height*3/5-5);
        if (mousePressed && (mouseButton == LEFT)) {
          x = 0;
          stonk = 0;
          n1 = height/2;
          background(224);
          start = true;
          bgline = true;
          countDown = true;
          second = 0;
          setOnlyOneTrue(moneyGame, 0);
        }
      }
    }
    textSize(20);
    fill(0);
    rect(width - height/10, height/25, height/5, height/12.5);
    fill(255);
    textAlign(RIGHT, CENTER);
    text("stonk : "+str(stonk), width - height/40, height/40);
    text("money : "+str(money)+"$", width - height/40, height/20);
    textAlign(CENTER, CENTER);
  }
}

void casino() { //CASINO 버튼을 누른 걸 감지하는 함수
  if (mouseX > width*3/4 - width/12 && mouseX < width*3/4 + width/12 && mouseY > height*3/4 - height/12 && mouseY < height*3/4 + height/12 && mousePressed && stonkorCasinoButtonAvailable && money >= 200) {
    money -= 200;
    setOnlyOneTrue(moneyGame, 3);
    stonkorCasinoButtonAvailable = false;
  }
}

void casinoUI() { //CASINO 버튼을 눌렀을 때 나오는 화면 (UI + 기능)
  background(255);
  textAlign(RIGHT, CENTER);
  textSize(70);
  text("money : " + money + "$", width - height/20, height/20);
  textAlign(CENTER, CENTER);
  textSize(80);
  fill(0);
  if (!firstNum) {
    a = int(random(1, 8));
  }
  if (!secondNum) {
    b = int(random(1, 8));
  }
  if (!thirdNum) {
    c = int(random(1, 8));
  }
  text(a, width/4, height/2);
  text(b, width/2, height/2);
  text(c, width*3/4, height/2);
  if (firstNum && secondNum && thirdNum) {
    textSize(30);
    if (a == b && b == c) {
      if (!moneyGived) {
        money += 200 * (4 + a);
        moneyGived = true;
      }
      text("You won " + str(4 * a) + " times!", width/2, height*3/4);
    } else if (a == b || a == c) {
      if (!moneyGived) {
        money += 200 * (2 * a + 3) / 6.0;
        moneyGived = true;
      }
      float result = (2 * a + 3) / 6.0;
      String textResult = String.format("%.2f", result);
      text("You won " + textResult + " times!", width/2, height*3/4);
    } else if (b == c) {
      if (!moneyGived) {
        money += 200 * (2 * b + 3) / 6.0;
        moneyGived = true;
      }
      float result = (2 * b + 3) / 6.0;
      String textResult = String.format("%.2f", result);
      text("You won " + textResult + " times!", width/2, height*3/4);
    } else {
      text("You lost all of your money.", width/2, height*3/4);
    }
  }
}

void mousePressed() { //마우스 버튼 클릭 1번을 감지하는 함수
  if (moneyGame.get(1)) { //BANK에서 마우스 버튼 클릭 1번을 감지하는 함수
    if (mouseX >= width / 8 && mouseX <= width * 3 / 8 &&
      mouseY >= height * 5 / 8 && mouseY <= height * 7 / 8) {
      if (money >= 1000) {
        money -= 1000;
        savings += 1000;
      } else {
        savings += money;
        money = 0;
      }
    }
    if (mouseX >= width * 5 / 8 && mouseX <= width * 7 / 8 &&
      mouseY >= height * 5 / 8 && mouseY <= height * 7 / 8) {
      if (savings >= 1000) {
        savings -= 1000;
        money += 1000;
      } else {
        money += savings;
        savings = 0;
      }
    }
  }
  if (moneyGame.get(3)) { //CASINO에서 마우스 버튼 클릭 1번을 감지하는 함수
    if (!firstNum) {
      firstNum = true;
    } else if (!secondNum) {
      secondNum = true;
    } else if (!thirdNum) {
      thirdNum = true;
    } else {
      setOnlyOneTrue(moneyGame, 0);
      firstNum = false;
      secondNum = false;
      thirdNum = false;
    }
  }
}
