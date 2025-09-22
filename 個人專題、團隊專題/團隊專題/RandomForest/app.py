import gradio as gr
import pickle
import pandas as pd

# 載入模型
with open("model.bin", "rb") as f:
    model = pickle.load(f)

# 映射字典
是否結過婚_map = {"有": "Yes", "無": "No"}
工作類型_map = {
    "children (我是小孩)": "children",
    "Govt_job (我是公務員)": "Govt_job",
    "Never_worked (我從未工作過)": "Never_worked",
    "Private (我在私營/私企上班)": "Private",
    "Self-employed (自僱)": "Self-employed",
}
居住類型_map = {"Rural (鄉村)": "Rural", "Urban (城市)": "Urban"}
性別_map = {"Male (男)": "Male", "Female (女)": "Female"}
高血壓_map = {"有": 1, "無": 0}
心臟病_map = {"有": 1, "無": 0}
吸菸狀態_map = {
    "formerly smoked (曾經吸菸)": "formerly smoked",
    "never smoked (從未吸菸)": "never smoked",
    "smokes (目前吸菸)": "smokes",
    "Unknown (未知)": "Unknown",
}

# 預測函式
def pred(年齡, 是否結過婚, 工作類型, 平均血糖值, 居住類型, 性別, 高血壓, 心臟病, 體重指數, 吸菸狀態):
    data_dict = {
        "age": 年齡,
        "ever_married": 是否結過婚_map.get(是否結過婚, 是否結過婚),
        "work_type": 工作類型_map.get(工作類型, 工作類型),
        "avg_glucose_level": 平均血糖值,
        "Residence_type": 居住類型_map.get(居住類型, 居住類型),
        "gender": 性別_map.get(性別, 性別),
        "hypertension": 高血壓_map.get(高血壓, 0),
        "heart_disease": 心臟病_map.get(心臟病, 0),
        "bmi": 體重指數,
        "smoking_status": 吸菸狀態_map.get(吸菸狀態, 吸菸狀態),
    }

    df = pd.DataFrame([data_dict])  # 轉成 DataFrame
    y_pred = model.predict(df)[0]   # 取第一筆預測

    return f'預測結果: {"⚠️ 高風險 (可能有中風風險)" if y_pred == 1 else "✅ 低風險 (中風風險較低)"}'


# Gradio 介面
with gr.Blocks() as demo:
    gr.Markdown("🧑‍⚕️ 中風風險預測")

    input_option = []
    input_option.append(gr.Number(label="年齡", maximum=100, minimum=1, step=1, value=30))
    input_option.append(gr.Radio(["有", "無"], label="是否結過婚"))
    input_option.append(gr.Dropdown(
        ["Private (我在私營/私企上班)", "children (我是小孩)", "Govt_job (我是公務員)",
         "Never_worked (我從未工作過)", "Self-employed (自僱)"],
        label="工作類型"))
    input_option.append(gr.Number(label="平均血糖值", maximum=300, minimum=50, step=10, value=100))
    input_option.append(gr.Radio(["Rural (鄉村)", "Urban (城市)"], label="居住類型"))

    with gr.Accordion("進階選項", open=False):
        input_option.append(gr.Radio(["Male (男)", "Female (女)"], label="性別"))
        input_option.append(gr.Radio(["有", "無"], label="高血壓"))
        input_option.append(gr.Radio(["有", "無"], label="心臟病"))
        input_option.append(gr.Number(label="體重指數(BMI)", maximum=100, minimum=10, step=1, value=22))
        input_option.append(gr.Dropdown(
            ["never smoked (從未吸菸)", "formerly smoked (曾經吸菸)",
             "smokes (目前吸菸)", "Unknown (未知)"],
            label="吸菸狀態"))

    pred_button = gr.Button("預測")
    output = gr.Textbox(label="預測結果")
    pred_button.click(fn=pred, inputs=input_option, outputs=output)

demo.launch()
