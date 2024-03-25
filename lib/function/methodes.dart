bool isOperator(String x) {
  if (x == "%" || x == "/" || x == "×" || x == "-" || x == "+" || x == "=") {
    return true;
  } else {
    return false;
  }
}

bool isaNumber(String x) {
  if (x == "0" ||
      x == "1" ||
      x == "2" ||
      x == "3" ||
      x == "4" ||
      x == "5" ||
      x == "6" ||
      x == "7" ||
      x == "8" ||
      x == "9") {
    return true;
  } else {
    return false;
  }
}
