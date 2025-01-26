import { Controller } from "@hotwired/stimulus";
import { Chart, PieController, ArcElement, Tooltip, Legend } from "chart.js"; // ✅ 必要なコンポーネントを追加

// 必要なコンポーネントを登録
Chart.register(PieController, ArcElement, Tooltip, Legend); // ✅ 追加

export default class extends Controller {
  connect() {
    document.addEventListener("turbo:load", () => this.loadChart());
    this.loadChart();
  }

  loadChart() {
    const ageGroups = JSON.parse(this.element.dataset.ageGroups);

    const ctx = this.element.getContext("2d");
    if (!ctx) {
      console.error("❌ Canvas の `getContext` が取得できません");
      return;
    }

    new Chart(ctx, {
      type: "pie", // ✅ ここで "pie" を使用
      data: {
        labels: Object.keys(ageGroups),
        datasets: [{
          data: Object.values(ageGroups),
          backgroundColor: ["#1abc9c", "#3498db", "#9b59b6"],
        }],
      },
    });
  }
}
