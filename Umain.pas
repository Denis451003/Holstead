unit Umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls, Math, XPMan;

type
  TMetrika = class(TForm)
    Memo_Class1: TMemo;
    Clean_But: TButton;
    __Label_Class: TLabel;
    Label_UniqueOperator: TLabel;
    Label_UniqueOperand: TLabel;
    Label_Operator: TLabel;
    Label_Operand: TLabel;
    Edit_UniqueOperator: TEdit;
    Edit_UniqueOperand: TEdit;
    Edit_AllOperator: TEdit;
    Edit_AllOperand: TEdit;
    Analyze_But: TButton;
    Label_Volume: TLabel;
    Label_Dictionary: TLabel;
    Label_Length: TLabel;
    Edit_Dictionary: TEdit;
    Edit_Length: TEdit;
    Edit_Volume: TEdit;
    xpmnfst1: TXPManifest;
    Exit_But: TButton;
    procedure FormCreate(Sender: TObject);
    procedure MemoClear(Memo: TMemo);
    procedure Clean_ButClick(Sender: TObject);
    function Operators_Search(Memo: TMemo; operatorsAllCount : Integer) : Integer;
    function Operands_Search(Memo: TMemo; operandsAllCount : Integer) : Integer;
    procedure Analyze_ButClick(Sender: TObject);
    procedure Exit_ButClick(Sender: TObject);
  public
    { Public declarations }
  end;
const
  signEmpty = '';
  signSpace = ' ';

  operatorNotWordCount = 46;
  massiveOperatorNotWord : array [1..operatorNotWordCount] of String = ('+','-','*','/','%','++','--','=','+=','-=','*=','/=','%=',
                                                                        '==','!=','<','<=','>','>=','||','&&','!','~','&','&=',
                                                                        '|','|=','^','^=','>>','>>=','<<','<<=','>>>','>>>=','(',')',
                                                                        '[',']','{','}',';',',','.','?',':');
  operatorWordCount = 9;
  massiveOperatorWord : array [1..operatorWordCount] of String = ('break','catch','for','if','new','return','switch','try','while');

  operatorNotNameOfFunctionCount = 6;
  massiveOperatorNotNameOfFunction : array [1..operatorNotNameOfFunctionCount] of String = ('while','for','if','switch','catch','try');

  operationSignsCount = 34;
  massiveOperationSigns : array [1..operationSignsCount] of String = ('=','+','-','*','/','%','+=','-=','*=','/=','%=',
                                                                      '!=','<','<=','>','>=','||','&&','!','~','&','&=','|','|=',
                                                                      '^','^=','>>','>>=','<<','<<=','>>>','>>>=','?',':');
  accessAtributCount = 3;
  massiveAccessAtributs : array [1..accessAtributCount] of String = ('public','private','protected');

  findElementsCount = 1000;

var
  Metrika: TMetrika;
  massiveUniqueOperators : array[1..findElementsCount] of String;
  massiveUniqueOperands : array[1..findElementsCount] of String;
  massiveAllOperands : array[1..findElementsCount] of String;
  massiveAllOperators : array[1..findElementsCount] of String;

implementation

{$R *.dfm}

procedure TMetrika.FormCreate(Sender: TObject);
begin
  Memo_Class1.Lines.Clear;
  Memo_Class1.Lines.LoadFromFile('class1.java');
  Analyze_But.Enabled := False;
end;


procedure TMetrika.MemoClear(Memo: TMemo);
const
  signTab = #9;
  signSlash = '/';
  signStar = '*';
var
 count, i, j, k, h, spaceCount, commentLinesCount, nextCommentLineNumber : Integer;
  analyzeString, temporaryString : String;

begin
  analyzeString := signEmpty;
  spaceCount := 0;
  for i := 0 to Memo.Lines.Count-1 do
  begin
    analyzeString := Memo.Lines[i];
    for j := 1 to length(analyzeString) do
      if analyzeString[j] = signSpace then inc(spaceCount);
    if spaceCount = length(analyzeString) then Memo.Lines.Delete(i)
    else
      Memo.Lines[i] := analyzeString;
    analyzeString := signEmpty;
    spaceCount := 0;
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo.Lines.Count-1 do
  begin
    analyzeString := Memo.Lines[i];
    j := 1;
    while j <= length(analyzeString) do
    begin
      if analyzeString[j] = signTab then
      begin
        Delete(analyzeString,j,1);
        dec(j);
      end;
      inc(j);
    end;
    Memo.Lines[i] := analyzeString;
    analyzeString := signEmpty;
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo.Lines.Count-1 do
  begin
    analyzeString := Memo.Lines[i];
    j := 1;
    while analyzeString[j] = signSpace do
      inc(j);
    Delete(analyzeString,1,j-1);
    Memo.Lines[i] := analyzeString;
    analyzeString := signEmpty;
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo.Lines.Count-1 do
  begin
    analyzeString := Memo.Lines[i];
    for j := 1 to length(analyzeString) do
      if (analyzeString[j-1] <> '"') and (analyzeString[j] = signSlash) and (analyzeString[j+1] = signSlash) then
        if j = 1 then Memo.Lines.Delete(i)
        else
        begin
          Delete(analyzeString,j,length(analyzeString)-j+1);
          Memo.Lines[i] := analyzeString;
        end;
    analyzeString := signEmpty;
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo.Lines.Count-1 do
  begin
    h := 0;
    commentLinesCount := 0;
    analyzeString := Memo.Lines[i];
    for j := 1 to length(analyzeString) do
      if (analyzeString[j] = signSlash) and (analyzeString[j+1] = signStar) and (analyzeString[j-1] <> '"') then
      begin
        if j = 1 then Memo.Lines.Delete(i)
        else
        begin
          Delete(analyzeString,j,length(analyzeString)-j+1);
          Memo.Lines[i] := analyzeString;
          h := 1;
        end;
        commentLinesCount := 1;
        break;
      end;

    k := 0;
    if commentLinesCount = 1 then
    begin
      for nextCommentLineNumber := i to Memo.Lines.Count-1 do
      begin
        temporaryString := Memo.Lines[nextCommentLineNumber];
        for j := 1 to length(temporaryString) do
          if (temporaryString[j] = signStar) and (temporaryString[j+1] = signSlash) and  (temporaryString[j-1] <> '"') then
          begin
            k := nextCommentLineNumber;
            break;
          end;
        if k <> 0 then break;
      end;
    end;

    if k <> 0 then
    begin
        if h = 0 then
          for j := k downto i do
            Memo.Lines.Delete(j);
        if h = 1 then
          for j := k downto i+1 do
            Memo.Lines.Delete(j);
    end;
    analyzeString := signEmpty;
  end;
end;


procedure TMetrika.Clean_ButClick(Sender: TObject);
var
  Memo: TMemo;
begin
  Memo := Memo_Class1;
  MemoClear(Memo);
  Analyze_But.Enabled := True;
  Clean_But.Enabled := False;
end;


function TMetrika.Operators_Search(Memo: TMemo; operatorsAllCount : Integer) : Integer;
const
  digitTwo = 2;
  signOpenBracket = '(';
  signCloseBracket = ')';
  signPoint = '.';
  signComma = ',';
var
  i, j, k, operatorsCount : Integer;
  analyzeString, nameFunction, accessString : String;
  isAccess, isChangeOperatorsCount : Boolean;

begin
  analyzeString := signEmpty;
  operatorsCount := 0;

  for i := 0 to Memo.Lines.Count-1 do
  begin
    analyzeString := Memo.Lines[i];

    for j := 1 to operatorWordCount do
      if Pos(massiveOperatorWord[j],analyzeString) <> 0 then
      begin
        inc(operatorsCount);
        massiveAllOperators[operatorsAllCount] := massiveOperatorWord[j];
        inc(operatorsAllCount);
      end;

    for j := 1 to length(analyzeString) do
      for k := 1 to operatorNotWordCount do
        if analyzeString[j] = massiveOperatorNotWord[k] then
        begin
          inc(operatorsCount);
          massiveAllOperators[operatorsAllCount] := massiveOperatorNotWord[k];
          inc(operatorsAllCount);
        end;
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo.Lines.Count-1 do
  begin
    analyzeString := Memo.Lines[i];
    isAccess := true;
    for j := 1 to length(analyzeString) do
      if analyzeString[j] = signSpace then break;

    accessString := copy(analyzeString,1,j-1);
    for j := 1 to accessAtributCount do
      if accessString = massiveAccessAtributs[j] then isAccess := false;
    if isAccess = false then continue;

    for j := 1 to length(analyzeString) do
    begin
      if analyzeString[j] = signOpenBracket then
      begin
        for k := j downto 1 do
          if (analyzeString[k] = signPoint) or (analyzeString[k] = signSpace) then break;

        for k := j-digitTwo downto 1 do
          if analyzeString[k] = signSpace then break;
        nameFunction := copy(analyzeString,k+1,j-k-1);
        inc(operatorsCount);
        isChangeOperatorsCount := false;

        for k := 1 to operatorNotNameOfFunctionCount do
          if nameFunction = massiveOperatorNotNameOfFunction[k] then
          begin
            dec(operatorsCount);
            isChangeOperatorsCount := true;
          end;

        if isChangeOperatorsCount = false then
        begin
          massiveAllOperators[operatorsAllCount] := nameFunction;
          inc(operatorsAllCount);
        end;
        nameFunction := signEmpty;
      end;
    end;
  end;

  Result := operatorsCount;
end;


function TMetrika.Operands_Search(Memo: TMemo; operandsAllCount : Integer) : Integer;
const
  operatorNew = 'new';
  operatorDouble = 3;
  operatorSingle = 2;
  operationEqual = '=';
  operationPlus = '+';
  operationMinus = '-';
  signOpenBracket = '(';
  signCloseBracket = ')';
  signPoint = '.';
  signComma = ',';
var
  i, j, k, h, operandsCount, lineOperationCount, lineBracketCount, lineArgumentsCount, operatorType: Integer;
  analyzeString, accessString, temporaryOperandLeft, temporaryOperandRight, temporaryFunctionInBrackets, temporaryArgument: String;
  isAccess : Boolean;

begin
  analyzeString := signEmpty;
  operandsCount := 0;

  for i := 0 to Memo.Lines.Count-1 do
  begin
    analyzeString := Memo.Lines[i];
    lineOperationCount := 0;

    for j := 1 to operationSignsCount do
      if Pos(massiveOperationSigns[j],analyzeString) <> 0 then
      begin
        inc(lineOperationCount);
        k := Pos(massiveOperationSigns[j],analyzeString);
        operatorType := operatorSingle;
        if (analyzeString[k+1] = operationEqual) or (analyzeString[k+1] = operationPlus) or (analyzeString[k+1] = operationMinus) then
          operatorType := operatorDouble;

        if lineOperationCount = 1 then
        begin
          for h := k-operatorSingle downto 1 do
            if (analyzeString[h] = signSpace) or (analyzeString[h] = signOpenBracket) then break;
          temporaryOperandLeft := copy(analyzeString,h+1,k-h-1);
          if temporaryOperandLeft <> signEmpty then
          begin
            inc(operandsCount);
            massiveAllOperands[operandsAllCount] := temporaryOperandLeft;
            inc(operandsAllCount);
          end;
        end;

        for h := k+operatorType to length(analyzeString)-1 do
          if (analyzeString[h] = signSpace) or (analyzeString[h] = signOpenBracket) or (analyzeString[h] = signCloseBracket) then break;
        temporaryOperandRight := copy(analyzeString,k+operatorType,h-k-operatorType);
        if temporaryOperandRight <> signEmpty then
        begin
            inc(operandsCount);
            if temporaryOperandRight = operatorNew then dec(operandsCount)
            else
            begin
              massiveAllOperands[operandsAllCount] := temporaryOperandRight;
              inc(operandsAllCount);
            end;
        end;
      end;
  end;

  analyzeString := signEmpty;
  for i := 0 to Memo.Lines.Count-1 do
  begin
    analyzeString := Memo.Lines[i];

    isAccess := true;
    for j := 1 to length(analyzeString) do
      if analyzeString[j] = signSpace then break;
    accessString := copy(analyzeString,1,j-1);
    for j := 1 to accessAtributCount do
      if accessString = massiveAccessAtributs[j] then isAccess := false;
    if isAccess = false then continue;
    if accessString = massiveOperatorNotNameOfFunction[operatorDouble] then continue;

    if Pos(signOpenBracket,analyzeString) <> 0 then
    begin
      for k := 1 to length(analyzeString) do
        if analyzeString[k] = signOpenBracket then break;
      lineBracketCount := 1;

      for h := k to length(analyzeString) do
      begin
        if analyzeString[h] = signOpenBracket then inc(lineBracketCount);
        if analyzeString[h] = signCloseBracket then dec(lineBracketCount);
        if lineBracketCount = 0 then break;
      end;
      temporaryFunctionInBrackets := copy(analyzeString,k+1,h-k-operatorDouble);

      lineArgumentsCount := 1;
      for j := 1 to length(temporaryFunctionInBrackets) do
        if temporaryFunctionInBrackets[j] = signComma then inc(lineArgumentsCount);

      for j := 1 to lineArgumentsCount do
      begin
        for h := 1 to length(temporaryFunctionInBrackets) do
          if temporaryFunctionInBrackets[h] = signComma then break;

        temporaryArgument := copy(temporaryFunctionInBrackets,1,h-1);
        Delete(temporaryFunctionInBrackets,1,h+1);

        for h := 1 to length(temporaryArgument) do
          if temporaryArgument[h] = signPoint then Delete(temporaryArgument,1,h);
        for h := 1 to length(temporaryArgument) do
          if temporaryArgument[h] = signOpenBracket then Delete(temporaryArgument,h,length(temporaryArgument)-h+1);
        for h := 1 to length(temporaryArgument) do
          if temporaryArgument[h] = signSpace then Delete(temporaryArgument,1,h);

        if temporaryArgument <> signEmpty then
        begin
          inc(operandsCount);
          massiveAllOperands[operandsAllCount] := temporaryArgument;
          inc(operandsAllCount);
        end;
      end;
    end;
  end;

  Result := operandsCount;
end;


procedure TMetrika.Analyze_ButClick(Sender: TObject);
const
  digitTwo = 2;
  digitThree = 3;
var
  Memo: TMemo;
  operatorsCount, operatorsAllCount, operandsCount, operandsAllCount : Integer;
  i, j, operatorsInMassiveCount, operatorsInUniqueMassiveCount, operandsInMassiveCount, operandsInUniqueMassiveCount : Integer;
  lengthOfProgram, dictionaryOfProgram : Integer;
  volumeOfProgram: Extended;
  temporaryRoundResultValue : Extended;
  analyzeString : String;

begin
  operatorsAllCount := 0;
  operandsAllCount := 0;

  Memo := Memo_Class1;
  operatorsCount := Operators_Search(Memo, 1);
  operatorsAllCount := operatorsAllCount + operatorsCount;
  operandsCount := Operands_Search(Memo, 1);
  operandsAllCount := operandsAllCount + operandsCount;

  Edit_AllOperator.Text := IntToStr(operatorsAllCount);
  Edit_AllOperand.Text := IntToStr(operandsAllCount);

  operatorsInUniqueMassiveCount := 0;
  for i := 1 to operatorsAllCount-1 do
  begin
    analyzeString := massiveAllOperators[i];
    operatorsInMassiveCount := 0;

    for j := 1 to operatorsAllCount-1 do
      if analyzeString = massiveAllOperators[j] then inc(operatorsInMassiveCount);

    if operatorsInMassiveCount = 1 then
    begin
      inc(operatorsInUniqueMassiveCount);
      massiveUniqueOperators[operatorsInUniqueMassiveCount] := analyzeString;
    end;
  end;
  Edit_UniqueOperator.Text := IntToStr(operatorsInUniqueMassiveCount);

  operandsInUniqueMassiveCount := 0;
  for i := 1 to operandsAllCount-1 do
  begin
    analyzeString := massiveAllOperands[i];
    operandsInMassiveCount := 0;

    for j := 1 to operandsAllCount-1 do
      if analyzeString = massiveAllOperands[j] then inc(operandsInMassiveCount);

    if operandsInMassiveCount = 1 then
    begin
      inc(operandsInUniqueMassiveCount);
      massiveUniqueOperands[operandsInUniqueMassiveCount] := analyzeString;
    end;
  end;
  Edit_UniqueOperand.Text := IntToStr(operandsInUniqueMassiveCount);

  lengthOfProgram := StrToInt(Edit_AllOperator.Text) + StrToInt(Edit_AllOperand.Text);
  Edit_Length.Text := IntToStr(lengthOfProgram);

  dictionaryOfProgram := StrToInt(Edit_UniqueOperator.Text) + StrToInt(Edit_UniqueOperand.Text);
  Edit_Dictionary.Text := IntToStr(dictionaryOfProgram);

  volumeOfProgram := lengthOfProgram*Log2(dictionaryOfProgram);
  temporaryRoundResultValue := RoundTo(volumeOfProgram, -digitTwo);
  Edit_Volume.Text := FloatToStr(temporaryRoundResultValue);
end;

procedure TMetrika.Exit_ButClick(Sender: TObject);
begin
  Close;
end;

end.
