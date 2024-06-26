import {
  Interpreter,
  Parser,
  values,
} from "https://esm.sh/@syuilo/aiscript@0.15.0/";

const interpreter = new Interpreter({}, {
  out(value: values.Value) {
    const to_str = interpreter.scope.get("Core:to_str") as values.VFn;

    const res = to_str.native!([value], {
      call: interpreter.execFn,
      registerAbortHandler: interpreter.registerAbortHandler,
      unregisterAbortHandler: interpreter.unregisterAbortHandler,
    }) as values.VStr;

    console.log(res.value);
  },
});

interpreter.exec(Parser.parse(await Deno.readTextFile("./ddsk.is")));
